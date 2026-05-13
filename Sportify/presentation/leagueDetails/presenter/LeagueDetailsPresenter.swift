//
//  LeagueDetailsPresenter.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation

protocol LeagueDetailsPresenter {

    var league: League { get }
    var upcomingMatches: [MatchEvent] { get }
    var recentMatches: [MatchEvent] { get }
    var teams: [Team] { get }

    func viewDidLoad()
}
