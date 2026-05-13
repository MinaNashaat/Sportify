//
//  FavouritesPresenterImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//

import UIKit

class FavouritesPresenterImpl:
FavouritesPresenter{

    weak var view: FavouritesView?

    private let localDataSource:
    SportifyLocalDataSource

    private let router: AppRouterImpl

    private weak var viewController:
    UIViewController?

    var leagues: [FavouriteLeague] = []

    init(
        view: FavouritesView,
        viewController: UIViewController,
        localDataSource: SportifyLocalDataSource,
        router: AppRouterImpl
    ) {

        self.view = view
        self.viewController = viewController
        self.localDataSource = localDataSource
        self.router = router
    }

    func viewDidLoad() {

        leagues =
        localDataSource.fetchFavouriteLeagues()

        view?.renderLeagues()
    }

    func didSelectLeague(
        at index: Int
    ) {

        let favouriteLeague =
        leagues[index]

        let league = League(
            id: favouriteLeague.leagueId,
            name: favouriteLeague.leagueTitle,
            country: nil,
            logoURL: URL(string: favouriteLeague.leagueImage),
            countryLogoURL: nil
        )

        router.navigateToLeagueDetails(
            from: viewController!,
            league: league,
            sportType: .football
        )
    }

    func deleteLeague(
        at index: Int
    ) {

        let league = leagues[index]

        localDataSource.deleteLeague(
            leagueId: league.leagueId
        )

        leagues.remove(at: index)

        view?.renderLeagues()
    }
}
