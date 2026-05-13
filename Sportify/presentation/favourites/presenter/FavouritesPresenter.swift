//
//  FavouritesPresenter.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//

import Foundation

protocol FavouritesPresenter {

    var leagues: [FavouriteLeague] { get }

    func viewDidLoad()

    func didSelectLeague(
        at index: Int
    )

    func deleteLeague(
        at index: Int
    )
}
