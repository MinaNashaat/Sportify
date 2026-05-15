//
//  MockAPIService.swift
//  Sportify
//
//  Created by Ahmed Salah on 16/05/2026.
//



import Foundation
@testable import Sportify


final class MockAPIService: APIService {

    var stubbedError: Error?
    var stubbedData: Data = Data()

    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        if let error = stubbedError {
            throw error
        }
        return try JSONDecoder().decode(T.self, from: stubbedData)
    }
}
