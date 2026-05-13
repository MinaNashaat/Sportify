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
        from view: UIViewController,
        sportType: SportType
    )

    func navigateToLeagueDetails(
        from view: UIViewController,
        league: League,
        sportType: SportType
    )

    func navigateToTeamDetails(
        from view: UIViewController,
        team: Team,
        sport: SportType,
        leagueName: String
    )
}
