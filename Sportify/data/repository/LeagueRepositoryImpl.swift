//
//  LeagueRepositoryImpl.swift
//  Sportify
//
//  Created by Mina on 12/05/2026.
//

import Foundation

class LeagueRepositoryImpl: LeagueRepository {

    private let remoteDataSource: SportifyRemoteDataSourceProtocol

    init(remoteDataSource: SportifyRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }

    func getLeagues(sport: SportType) async throws -> [League] {

        let response = try await remoteDataSource.getLeagues(sport: sport)

        return response.result.toDomain()
    }
}
