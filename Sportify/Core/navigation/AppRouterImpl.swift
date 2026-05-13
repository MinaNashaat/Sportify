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

        guard let tabBar = storyboard.instantiateViewController(
            withIdentifier: "myTabBarController"
        ) as? myTabBarController else {
            fatalError("Cannot load myTabBarController")
        }

        // No UINavigationController wrapper — look directly
        guard let sportsVC = tabBar.viewControllers?
            .compactMap({ $0 as? SportsViewController })
            .first
        else {
            fatalError("Cannot load SportsViewController")
        }

        let remoteDataSource = SportifyRemoteDataSourceImpl()
        let repository = HomeRepositoryImpl(remoteDataSource: remoteDataSource)
        let router = AppRouterImpl()
        let presenter = HomePresenterImpl(
            view: sportsVC,
            repository: repository,
            router: router
        )
        sportsVC.presenter = presenter

        return tabBar
    }
    // MARK: - Navigation

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
        let presenter = LeagueDetailsPresenterImpl(
            view: vc,
            repository: repository,
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
        from view: UIViewController
    ) {

        let vc =
        AppRouterImpl.storyboard.instantiateViewController(
            withIdentifier: "teamEvents"
        ) as! teamDetailsViewController

        view.navigationController?
            .pushViewController(
                vc,
                animated: true
            )
    }
}
