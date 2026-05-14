//
//  SportifyRemoteDatasourceImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//


class SportifyRemoteDataSourceImpl: SportifyRemoteDataSourceProtocol {

    private let apiService: APIService

    init(apiService: APIService = APIServiceImpl.shared) {
        self.apiService = apiService
    }

    func getLeagues(sport: SportType) async throws -> LeagueResponseDTO {
        try await apiService.request(endpoint: SportifyEndpoints.leagues( sport: sport)
        )
    }

    func getLiveMatches(sport: SportType) async throws -> LiveMatchResponseDTO {
        try await apiService.request(endpoint: SportifyEndpoints.liveScore(sport: sport)
        )
    }

    func getLeagueEvents(sport: SportType, leagueId: Int, from: String, to: String) async throws -> EventResponseDTO {

        try await apiService.request(endpoint: SportifyEndpoints.leagueEvents(sport: sport, leagueId: leagueId, from: from, to: to)
        )
    }

    func getTeamEvents(sport: SportType, leagueId: Int, teamId: Int, from: String, to: String) async throws -> EventResponseDTO {
        try await apiService.request(endpoint: SportifyEndpoints.teamEvents(sport: sport, leagueId: leagueId, teamId: teamId, from: from, to: to)
        )
    }

    func getLeagueTeams(sport: SportType, leagueId: Int) async throws -> TeamResponseDTO {

        try await apiService.request(endpoint: SportifyEndpoints.leagueTeams(sport: sport,leagueId: leagueId)
        )
    }
}
