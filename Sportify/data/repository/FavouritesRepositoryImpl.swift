//
//  FavouritesRepositoryImpl.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//


import Foundation

class FavouritesRepositoryImpl:
FavouritesRepository {

    private let localDataSource:
    SportifyLocalDataSource

    init(
        localDataSource:
        SportifyLocalDataSource
    ) {

        self.localDataSource =
        localDataSource
    }

    func fetchFavouriteLeagues()
    -> [FavouriteLeague] {

        localDataSource
            .fetchFavouriteLeagues()
    }

    func deleteLeague(
        leagueId: Int
    ) {

        localDataSource.deleteLeague(
            leagueId: leagueId
        )
    }

    func insertLeague(
        league: FavouriteLeague
    ) {

        localDataSource.insertLeague(
            league: league
        )
    }

    func isFavourite(
        leagueId: Int
    ) -> Bool {

        localDataSource.isFavourite(
            leagueId: leagueId
        )
    }
}
