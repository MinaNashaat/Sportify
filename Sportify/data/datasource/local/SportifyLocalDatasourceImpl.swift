//
//  SportifyLocalDatasourceImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

class SportifyLocalDataSourceImpl: SportifyLocalDataSource {

    private let cacheService : CacheService

    init(cacheService : CacheService = CacheServiceImpl.shared) {
        self.cacheService = cacheService
    }

    func insertLeague(league: FavouriteLeague) {
        cacheService.insertLeague(league: league)
    }

    func fetchFavouriteLeagues() -> [FavouriteLeague] {
        cacheService.fetchLeagues()
    }

    func deleteLeague(leagueId: Int) {
        cacheService.deleteLeague(leagueId: leagueId)
    }

    func isFavourite(leagueId: Int) -> Bool {
        cacheService.isFavourite(leagueId: leagueId)
    }
}
