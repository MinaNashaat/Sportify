//
//  LeagueListPresenterImpl.swift
//  Sportify
//
//  Created by Mina on 12/05/2026.
//

import Foundation
import UIKit

class LeagueListPresenterImpl: LeagueListPresenter {

    weak var view: LeagueListView?

    private let repository: LeagueRepository
    private let router: AppRouter
    let sportType: SportType

    var leagues: [League] = []

    init(
        view: LeagueListView,
        repository: LeagueRepository,
        router: AppRouter,
        sportType: SportType
    ) {
        self.view = view
        self.repository = repository
        self.router = router
        self.sportType = sportType
    }

    func viewDidLoad() {
        fetchLeagues()
    }

    private func fetchLeagues() {

        view?.showLoading()

        Task {
            do {
                let result =
                    try await repository.getLeagues(sport: sportType)

                self.leagues = result

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

    func didSelectLeague(at index: Int) {
        let league = leagues[index]
        router.navigateToLeagueDetails(
            from: view as! UIViewController,
            league: league,
            sportType: sportType
        )
    }
}
