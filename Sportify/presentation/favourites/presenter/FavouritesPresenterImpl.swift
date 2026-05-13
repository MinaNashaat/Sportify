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

    private let repository:
    FavouritesRepository

    private let router: AppRouterImpl


    var leagues: [FavouriteLeague] = []

    init(
        view: FavouritesView,
        repository: FavouritesRepository,
        router: AppRouterImpl
    ) {

        self.view = view
        self.repository = repository
        self.router = router
    }

    func viewDidLoad() {

        leagues =
        repository.fetchFavouriteLeagues()

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
            from: view as! UIViewController,
            league: league,
            sportType: .football
        )
    }

    func deleteLeague(
        at index: Int
    ) {

        let league = leagues[index]

        repository.deleteLeague(
            leagueId: league.leagueId
        )

        leagues.remove(at: index)

        view?.renderLeagues()
    }
}
