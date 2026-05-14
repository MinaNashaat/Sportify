//
//  Endpoint.swift
//  VIPERDemo
//
//  Created by Esraa Hassan on 11/05/2026.
//

import Foundation
import Alamofire

protocol Endpoint {
    var path: String { get }
    var parameters: Parameters { get }
}
