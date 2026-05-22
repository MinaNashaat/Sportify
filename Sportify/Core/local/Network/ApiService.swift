//
//  NetworkClientProtocol.swift
//  VIPERDemo
//
//  Created by Esraa Hassan on 11/05/2026.
//

import Foundation

protocol APIService {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}
