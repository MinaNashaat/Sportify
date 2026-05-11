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

    private let repository:
    HomeRepository

    private let router: AppRouter

    private var liveMatches: [LiveMatch] = []

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

        fetchLiveMatches()
    }

    private func fetchLiveMatches() {

        view?.showLoading()

        Task {

            do {

                let matches =
                try await repository.getLiveMatches(
                    sport: .football
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

    func didSelectSport(at index: Int) {

    }

    func didSelectLeague() {

    }
    func getLiveMatch(at index: Int) -> LiveMatch? {
        guard index >= 0 && index < liveMatches.count else { return nil }
        return liveMatches[index]
    }

    func getLiveMatchesCount() -> Int {
        return liveMatches.count
    }
}
