//
//  HomePresenter.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

protocol HomePresenter {
    func viewDidLoad()
    func getLiveMatch(at index: Int) -> LiveMatch?
    func getLiveMatchesCount() -> Int
    func didSelectSport(at index: Int)
    func didSelectLeague()

    var liveMatches: [LiveMatch] { get }

    var selectedSportType: SportType { get }
    
//    func viewDidLoad()
//
//    func didSelectSport(
//        at index: Int
//    )


}
