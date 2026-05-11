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

    static func createHomeModule()
    -> UIViewController {

        guard let view =
                storyboard.instantiateViewController(
                    withIdentifier: "myTabBarController"
                ) as? myTabBarController
        else {

            fatalError(
                "Cannot load SportsViewController"
            )
        }

        let router = AppRouterImpl()

        // presenter/interactor here later

        // view.presenter = presenter

        return view
    }


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
