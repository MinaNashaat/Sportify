//
//  FavouritesViewProtocol.swift
//  Sportify
//
//  Created by Ahmed Salah on 13/05/2026.
//

import Foundation

protocol FavouritesView: AnyObject {

    func renderLeagues()

    func showDeleteAlert(
        index: Int
    )

    func showNoInternetAlert()
}
