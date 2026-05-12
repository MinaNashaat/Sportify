//
//  TeamDetailsRepositoryImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//

import Foundation

class TeamDetailsRepositoryImpl: TeamDetailsRepository {

    private let remoteDataSource: SportifyRemoteDataSourceProtocol

    init(remoteDataSource: SportifyRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func getTeamEvents(
        sport: SportType,
        leagueId: Int,
        teamId: Int,
        from: String,
        to: String
    ) async throws -> [MatchEvent] {

        let response = try await remoteDataSource.getTeamEvents(
            sport: sport,
            leagueId: leagueId,
            teamId: teamId,
            from: from,
            to: to
        )

        return response.result.toDomain()
    }
}
