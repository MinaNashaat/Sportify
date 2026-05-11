//
//  TeamDetailsRepository.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//

import Foundation

protocol TeamDetailsRepository {
    func getTeamEvents(
        sport: SportType,
        leagueId: Int,
        teamId: Int,
        from: String,
        to: String
    ) async throws -> [MatchEvent]
}
