//
//  AppRouterImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//



import UIKit

class AppRouterImpl: AppRouter {


    private static let storyboard =
    UIStoryboard(
        name: "Main",
        bundle: nil
    )


    static func createOnboardingModule()
    -> UIViewController {

        guard let view =
                storyboard.instantiateViewController(
                    withIdentifier: "startOnboarding"
                ) as? myPageViewController
        else {

            fatalError(
                "Cannot load myPageViewController"
            )
        }

        return view
    }

    static func createHomeModule() -> UIViewController {

        guard let tabBar =
                storyboard.instantiateViewController(
                    withIdentifier: "myTabBarController"
                ) as? myTabBarController
        else {

            fatalError("Cannot load myTabBarController")
        }


        guard let sportsVC =
                tabBar.viewControllers?
                .compactMap({ $0 as? SportsViewController })
                .first
        else {

            fatalError("Cannot load SportsViewController")
        }

        let remoteDataSource =
        SportifyRemoteDataSourceImpl()

        let repository =
        HomeRepositoryImpl(
            remoteDataSource: remoteDataSource
        )

        let router = AppRouterImpl()

        let sportsPresenter =
        HomePresenterImpl(
            view: sportsVC,
            repository: repository,
            router: router
        )

        sportsVC.presenter = sportsPresenter


        guard let favouritesVC =
                tabBar.viewControllers?
                .compactMap({
                    $0 as? FavouritesUIViewController
                })
                .first
        else {

            fatalError(
                "Cannot load FavouritesUIViewController"
            )
        }

        let localDataSource =
        SportifyLocalDataSourceImpl()

        let favRepository =
        FavouritesRepositoryImpl(
            localDataSource: localDataSource
        )

        let favouritesPresenter =
        FavouritesPresenterImpl(
            view: favouritesVC,
            repository: favRepository,
            router: router
        )



        favouritesVC.presenter =
        favouritesPresenter

        return tabBar
    }
    func navigateToLeagueList(
        from view: UIViewController,
        sportType: SportType
    ) {

        let vc =
        AppRouterImpl.storyboard.instantiateViewController(
            withIdentifier: "leagueList"
        ) as! LeagueListViewController

        let remoteDataSource = SportifyRemoteDataSourceImpl()
        let repository = LeagueRepositoryImpl(remoteDataSource: remoteDataSource)
        let router = AppRouterImpl()

        let presenter = LeagueListPresenterImpl(
            view: vc,
            repository: repository,
            router: router,
            sportType: sportType
        )

        vc.presenter = presenter
        
        view.navigationController?
            .pushViewController(
                vc,
                animated: true
            )
    }

    func navigateToLeagueDetails(
        from view: UIViewController,
        league: League,
        sportType: SportType
    ) {

        let vc =
        AppRouterImpl.storyboard.instantiateViewController(
            withIdentifier: "leagueEvent"
        ) as! leagueDetailsViewController
        let remoteDataSource = SportifyRemoteDataSourceImpl()
        let repository = LeagueDetailsRepositoryImpl(remoteDataSource: remoteDataSource)
        let router = AppRouterImpl()
        let presenter = LeagueDetailsPresenterImpl(
            view: vc,
            repository: repository,
            router: router,
            league: league,
            sportType: sportType
        )
        vc.presenter = presenter
//        vc.league = league
//        vc.sportType = sportType
        view.navigationController?
            .pushViewController(
                vc,
                animated: true
            )
    }

    func navigateToTeamDetails(
        from view: UIViewController,
        team: Team,
        sport: SportType,
        leagueName: String
    ) {

        let vc =
        AppRouterImpl.storyboard.instantiateViewController(
            withIdentifier: "teamEvents"
        ) as! teamDetailsViewController

        let remoteDataSource =
        SportifyRemoteDataSourceImpl()

        let repository =
        TeamDetailsRepositoryImpl(
            remoteDataSource: remoteDataSource
        )

        let router = AppRouterImpl()

        let presenter =
        TeamDetailsPresenterImpl(
            view: vc,
            repository: repository,
            router: router
        )

        presenter.teamId = team.id
        presenter.sport = sport

        vc.selectedTeam = team
        vc.selectedLeagueName = leagueName
        vc.presenter = presenter

        view.navigationController?
            .pushViewController(
                vc,
                animated: true
            )
    }
    static func createFavouritesModule()
    -> UIViewController {

        let vc =
        storyboard.instantiateViewController(
            withIdentifier: "favouritesVC"
        ) as! FavouritesUIViewController



        let router =
        AppRouterImpl()

        let localDataSource =
        SportifyLocalDataSourceImpl()

        let repository =
        FavouritesRepositoryImpl(
            localDataSource: localDataSource
        )

        let favouritesPresenter =
        FavouritesPresenterImpl(
            view: vc,
            repository: repository,
            router: router
        )

        vc.presenter = favouritesPresenter

        return vc
    }
}
