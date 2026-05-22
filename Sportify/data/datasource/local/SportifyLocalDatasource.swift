//
//  SportifyLocalDatasource.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//
import Foundation

protocol SportifyLocalDataSource {

    func insertLeague(league: FavouriteLeague)

    func fetchFavouriteLeagues() -> [FavouriteLeague]

    func deleteLeague(leagueId: Int)

    func isFavourite(leagueId: Int) -> Bool
}
