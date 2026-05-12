//
//  LeagueListPresenter.swift
//  Sportify
//
//  Created by Mina on 12/05/2026.
//

import Foundation

protocol LeagueListPresenter {

    var leagues: [League] { get }

    var sportType: SportType { get }

    func viewDidLoad()

    func didSelectLeague(at index: Int)
}
