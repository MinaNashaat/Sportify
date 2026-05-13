//
//  LeagueDetailsRepositoryImpl.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation

class LeagueDetailsRepositoryImpl: LeagueDetailsRepository {

    private let remoteDataSource: SportifyRemoteDataSourceProtocol

    init(remoteDataSource: SportifyRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func getLeagueEvents(
        sport: SportType,
        leagueId: Int,
        from: String,
        to: String
    ) async throws -> [MatchEvent] {

        let response = try await remoteDataSource.getLeagueEvents(
            sport: sport,
            leagueId: leagueId,
            from: from,
            to: to
        )

        return response.result.toDomain()
    }

    func getLeagueTeams(
        sport: SportType,
        leagueId: Int
    ) async throws -> [Team] {

        let response = try await remoteDataSource.getLeagueTeams(
            sport: sport,
            leagueId: leagueId
        )

        return response.result.toDomain()
    }
}
