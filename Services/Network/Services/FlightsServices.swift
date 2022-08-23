//
//  FlightsServices.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 19.08.2022.
//

import Foundation
import Combine

final class FlightsService {

    private let service: Networkable
    
    init(service: Networkable = NetworkService()) {
        self.service = service
    }
}

extension FlightsService {
    
    func fetchFlights(request: FlightsRequest = FlightsRequest()) -> AnyPublisher<FlightsResponse, Error> {
        guard let url = URL(string: "https://api.skypicker.com/flights\(request.parameters)") else {
            return Fail(error: AppError.urlError)
                .mapError { $0 as Error }
                .eraseToAnyPublisher()
        }

        return service.request(url)
    }
}
