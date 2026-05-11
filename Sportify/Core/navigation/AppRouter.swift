//
//  AppRouter.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import UIKit

protocol AppRouter {

    static func createHomeModule() -> UIViewController

    static func createOnboardingModule() -> UIViewController

    func navigateToLeagueList(
        from view: UIViewController
    )

    func navigateToLeagueDetails(
        from view: UIViewController
    )

    func navigateToTeamDetails(
        from view: UIViewController
    )
}
