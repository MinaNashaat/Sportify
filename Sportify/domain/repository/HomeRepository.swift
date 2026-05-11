//
//  HomeRepository.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//

import Foundation

protocol HomeRepository {

    func getLiveMatches(
        sport: SportType
    ) async throws -> [LiveMatch]
}
