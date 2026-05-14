//
//  CacheService.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

protocol CacheService {

    func insertLeague(league: FavouriteLeague)

    func fetchLeagues() -> [FavouriteLeague]

    func deleteLeague(leagueId: Int)

    func isFavourite(leagueId: Int) -> Bool
}
