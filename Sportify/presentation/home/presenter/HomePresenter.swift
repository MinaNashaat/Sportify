//
//  HomePresenter.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

protocol HomePresenter {

    var liveMatches: [LiveMatch] { get }

    func viewDidLoad()

    func didSelectSport(
        at index: Int
    )

    func didSelectLeague()
}
