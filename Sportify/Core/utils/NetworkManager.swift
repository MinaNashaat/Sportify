//
//  NetworkManager.swift
//  Sportify
//
//  Created by Ahmed Salah on 14/05/2026.
//


import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    private let reachability = NetworkReachabilityManager()

    private init() {}

    var isReachable: Bool {
        return reachability?.isReachable ?? false
    }
}
