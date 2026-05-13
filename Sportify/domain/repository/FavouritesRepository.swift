//
//  FavouritesRepository.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//

import Foundation

protocol FavouritesRepository {

    func fetchFavouriteLeagues()
    -> [FavouriteLeague]

    func deleteLeague(
        leagueId: Int
    )

    func insertLeague(
        league: FavouriteLeague
    )

    func isFavourite(
        leagueId: Int
    ) -> Bool
}
