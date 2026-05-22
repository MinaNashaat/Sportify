//
//  presenter.swift
//  Sportify
//
//  Created by Mina on 12/05/2026.
//

import Foundation

protocol LeagueRepository {
    func getLeagues(sport: SportType) async throws -> [League]
}
