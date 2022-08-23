//
//  NetworkService.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 18.08.2022.
//

import Foundation
import Combine

enum AppError: Error {
    case serverError
    case urlError
}

protocol Networkable {
    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error>
}

final class NetworkService: Networkable {
    
    private var cancellables = Cancellables()

    func request<T: Decodable>(_ url: URL) -> AnyPublisher<T, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap({ result in
                guard
                    let urlResponse = result.response as? HTTPURLResponse,
                    (200...299).contains(urlResponse.statusCode)
                else {
                    throw AppError.serverError
                }

                return try result.data.decode()
            })
            .eraseToAnyPublisher()
    }
}

extension Data {
    func decode<T: Decodable>(type: T.Type = T.self) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoded = try decoder.decode(type, from: self)
            return decoded
        } catch {
            print("❗DECODING ERROR❗: \(error)")
            throw error
        }
    }
}
