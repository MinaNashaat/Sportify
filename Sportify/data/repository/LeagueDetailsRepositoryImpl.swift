//
//  LeagueDetailsRepositoryImpl.swift
//  Sportify
//
//  Created by Mina on 13/05/2026.
//

import Foundation

class LeagueDetailsRepositoryImpl: LeagueDetailsRepository {

    private let remoteDataSource: SportifyRemoteDataSourceProtocol
    private let localDataSource: SportifyLocalDataSource
    
    init(remoteDataSource: SportifyRemoteDataSourceProtocol, localDataSource: SportifyLocalDataSource = SportifyLocalDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource  = localDataSource
    }

    func getLeagueEvents(sport: SportType, leagueId: Int, from: String, to: String) async throws -> [MatchEvent] {

        let response = try await remoteDataSource.getLeagueEvents(sport: sport, leagueId: leagueId, from: from, to: to)

        return response.result.toDomain()
    }

    func getLeagueTeams(sport: SportType, leagueId: Int) async throws -> [Team] {

        let response = try await remoteDataSource.getLeagueTeams(sport: sport, leagueId: leagueId)

        return response.result.toDomain()
    }
    
    func isFavourite(leagueId: Int) -> Bool {
        localDataSource.isFavourite(leagueId: leagueId)
    }

    func addFavourite(league: League) {
        let favourite = FavouriteLeague(leagueId: league.id, leagueTitle: league.name, leagueImage: league.logoURL?.absoluteString ?? "")
        localDataSource.insertLeague(league: favourite)
    }

    func removeFavourite(leagueId: Int) {
        localDataSource.deleteLeague(leagueId: leagueId)
    }
}
