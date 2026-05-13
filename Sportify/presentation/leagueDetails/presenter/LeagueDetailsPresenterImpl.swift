//
//  LeagueDetailsPresenterImpl.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation
import UIKit

class LeagueDetailsPresenterImpl: LeagueDetailsPresenter {

    weak var view: LeagueDetailsView?
    private let router: AppRouter

    private let repository: LeagueDetailsRepository

    let sportType: SportType
    let league: League

    var upcomingMatches: [MatchEvent] = []
    var recentMatches: [MatchEvent] = []
    var teams: [Team] = []

    init(
        view: LeagueDetailsView,
        repository: LeagueDetailsRepository,
        router: AppRouter,
        league: League,
        sportType: SportType
    ) {
        self.view = view
        self.repository = repository
        self.router = router
        self.league = league
        self.sportType = sportType
    }

    func viewDidLoad() {
        fetchData()
    }

    private func fetchData() {

        view?.showLoading()

        let from = DateHelper.dateString(daysOffset: -30)
        let to   = DateHelper.dateString(daysOffset:  30)

        Task {
            do {
                async let eventsTask = repository.getLeagueEvents(
                    sport: sportType,
                    leagueId: league.id,
                    from: from,
                    to: to
                )
                async let teamsTask = repository.getLeagueTeams(
                    sport: sportType,
                    leagueId: league.id
                )

                let (events, fetchedTeams) = try await (eventsTask, teamsTask)

                self.upcomingMatches = events.filter {
                    if case .upcoming = $0.state { return true }
                    if case .live = $0.state     { return true }
                    return false
                }

                self.recentMatches = events.filter {
                    if case .finished = $0.state { return true }
                    return false
                }

                self.teams = fetchedTeams

                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.reloadData()
                }

            } catch {
                await MainActor.run {
                    self.view?.hideLoading()
                    self.view?.showError(message: error.localizedDescription)
                }
            }
        }
    }

    func didSelectTeam(at index: Int) {

        guard index < teams.count,
              let viewController = view as? UIViewController
        else {
            return
        }

        let selectedTeam = teams[index]

        router.navigateToTeamDetails(
            from: viewController,
            team: selectedTeam,
            sport: sportType,
            leagueName: league.name
        )
    }
}
