//
//  NetworkClient.swift
//  Sportify
//
//  Created by Ahmed Salah on 11/05/2026.
//
import Alamofire
import Foundation

class APIServiceImpl: APIService {

    static let shared = APIServiceImpl()

    private init() {}

    private let baseURL = "https://apiv2.allsportsapi.com/"
    private let apiKey = "cba2ee62e3058eb4138e75f253d8087253c0f68a4ecab1d1646b4d5d97b61d1e"
    private let session: Session = {

        let configuration = URLSessionConfiguration.default

        configuration.timeoutIntervalForRequest = 15
        configuration.timeoutIntervalForResource = 30

        configuration.requestCachePolicy =
        .returnCacheDataElseLoad

        configuration.urlCache = URLCache(
            memoryCapacity: 50 * 1024 * 1024,
            diskCapacity: 100 * 1024 * 1024,
            diskPath: "sportify_cache"
        )

        return Session(configuration: configuration)

    }()

    func request<T: Decodable>(
        endpoint: Endpoint
    ) async throws -> T {

        let url = baseURL + endpoint.path

        var params = endpoint.parameters
        params["APIkey"] = apiKey

        return try await withCheckedThrowingContinuation {
            continuation in

            session.request(
                url,
                method: .get,
                parameters: params
            )
            .validate()
            .responseDecodable(of: T.self) { response in

                switch response.result {

                case .success(let data):

                    continuation.resume(
                        returning: data
                    )

                case .failure(let error):

                    continuation.resume(
                        throwing: error
                    )
                }
            }
        }
    }
}
