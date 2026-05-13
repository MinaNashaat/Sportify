//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation

protocol LeagueDetailsPresenter {

    var league: League { get }
    var sportType: SportType { get }

    var upcomingMatches: [MatchEvent] { get }
    var recentMatches: [MatchEvent] { get }
    var teams: [Team] { get }

    func viewDidLoad()
<<<<<<< 51-check-the-team-in-favourite-or-not
    func isFavourite() -> Bool
    func toggleFavourite()
=======
    func didSelectTeam(at index: Int)
>>>>>>> dev
}
