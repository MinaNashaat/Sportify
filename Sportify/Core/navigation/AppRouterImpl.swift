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
        from view: UIViewController
    ) {

        let vc =
        AppRouterImpl.storyboard.instantiateViewController(
            withIdentifier: "leagueList"
        ) as! LeagueListViewController

        view.navigationController?
            .pushViewController(
                vc,
                animated: true
            )
    }

    func navigateToLeagueDetails(
        from view: UIViewController
    ) {

        let vc =
        AppRouterImpl.storyboard.instantiateViewController(
            withIdentifier: "leagueEvent"
        ) as! leagueDetailsViewController

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
