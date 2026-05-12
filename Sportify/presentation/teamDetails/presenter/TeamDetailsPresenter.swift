//
//  TeamDetailsPresenter.swift
//  Sportify
//
//  Created by Ahmed Salah on 12/05/2026.
//

import Foundation

protocol TeamDetailsPresenter {
    func viewDidLoad()
    func getMatchEvent(at index: Int) -> MatchEvent?
    func getMatchEventsCount() -> Int
}
