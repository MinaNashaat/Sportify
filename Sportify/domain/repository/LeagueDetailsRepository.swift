//
//  LeagueDetailsRepository.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation

protocol LeagueDetailsRepository {

    func getLeagueEvents(sport: SportType, leagueId: Int, from: String, to: String) async throws -> [MatchEvent]

    func getLeagueTeams(sport: SportType, leagueId: Int) async throws -> [Team]
    func isFavourite(leagueId: Int) -> Bool
    func addFavourite(league: League)
    func removeFavourite(leagueId: Int)
}
