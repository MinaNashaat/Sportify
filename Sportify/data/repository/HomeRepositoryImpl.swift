//
//  HomeRepositoryImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

class HomeRepositoryImpl: HomeRepository {

    private let remoteDataSource: SportifyRemoteDataSourceProtocol

    init(
        remoteDataSource: SportifyRemoteDataSourceProtocol
    ) {
        self.remoteDataSource = remoteDataSource
    }

    func getLiveMatches(
            sport: SportType
        ) async throws -> [LiveMatch] {

            let response =
            try await remoteDataSource
                .getLiveMatches(
                    sport: sport
                )

            return response.result.toDomain()
        }
}
