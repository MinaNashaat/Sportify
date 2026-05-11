//
//  SportifyRemoteDatasource.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//



import Foundation

protocol SportifyRemoteDataSourceProtocol {

    func getLeagues(
        sport: SportType
    ) async throws -> LeagueResponseDTO

    func getLiveMatches(
        sport: SportType
    ) async throws -> LiveMatchResponseDTO

    func getLeagueEvents(
        sport: SportType,
        leagueId: Int,
        from: String,
        to: String
    ) async throws -> EventResponseDTO

    func getTeamEvents(
        sport: SportType,
        leagueId: Int,
        teamId: Int,
        from: String,
        to: String
    ) async throws -> EventResponseDTO

    func getLeagueTeams(
        sport: SportType,
        leagueId: Int
    ) async throws -> TeamResponseDTO
}
