//
//  TeamDetailsPresenterImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//

import Foundation

class TeamDetailsPresenterImpl: TeamDetailsPresenter {

    weak var view: TeamDetailsView?

    private let repository: TeamDetailsRepository
    private let router: AppRouter

    private var matchEvents: [MatchEvent] = []

    var sport: SportType = .football
    var leagueId: Int = 0
    var teamId: Int = 0
    var from: String = ""
    var to: String = ""

    init(
        view: TeamDetailsView,
        repository: TeamDetailsRepository,
        router: AppRouter
    ) {
        self.view = view
        self.repository = repository
        self.router = router
    }

    func viewDidLoad() {
        fetchTeamEvents()
    }

    private func fetchTeamEvents() {

        view?.showLoading()

        Task {
            do {
                let events = try await repository.getTeamEvents(
                    sport: sport,
                    leagueId: leagueId,
                    teamId: teamId,
                    from: from,
                    to: to
                )

                self.matchEvents = events

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

    func getMatchEvent(at index: Int) -> MatchEvent? {
        guard index >= 0 && index < matchEvents.count else { return nil }
        return matchEvents[index]
    }

    func getMatchEventsCount() -> Int {
        return matchEvents.count
    }
}
