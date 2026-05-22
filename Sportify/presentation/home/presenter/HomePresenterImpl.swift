//
//  HomePresenterImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation
import UIKit

class HomePresenterImpl: HomePresenter {

    weak var view: HomeView?

    private let repository: HomeRepository
    private let router: AppRouter


    var liveMatches: [LiveMatch] = []

    private(set) var selectedSportType: SportType = .football


    init(
        view: HomeView,
        repository: HomeRepository,
        router: AppRouter
    ) {
        self.view = view
        self.repository = repository
        self.router = router
    }


    func viewDidLoad() {
        fetchLiveMatches(for: .football)
    }


    private func fetchLiveMatches(for sport: SportType) {

        view?.showLoading()

        Task {

            do {

                let matches = try await repository.getLiveMatches(
                    sport: sport
                )

                self.liveMatches = matches

                await MainActor.run {

                    self.view?.hideLoading()
                    self.view?.reloadData()
                }

            } catch {

                await MainActor.run {

                    self.view?.hideLoading()

                    self.view?.showError(
                        message: error.localizedDescription
                    )
                }
            }
        }
    }


    func didSelectSport(
            at index: Int
        ) {

            guard NetworkManager
                .shared
                .isReachable else {

                view?.showNoInternetAlert()

                return
            }

            let sport =
            SportType.allCases[index]

            selectedSportType =
            sport

            fetchLiveMatches(
                for: sport
            )

            guard let viewController =
                    view as? UIViewController else {
                return
            }

            router.navigateToLeagueList(
                from: viewController,
                sportType: selectedSportType
            )
        }





    func getLiveMatch(at index: Int) -> LiveMatch? {

        guard index >= 0 &&
                index < liveMatches.count else {
            return nil
        }

        return liveMatches[index]
    }

    func getLiveMatchesCount() -> Int {
        return liveMatches.count
    }
}
