//
//  FlightsRequest.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import Foundation

struct FlightsRequest {

    let parameters: String

    init(dateFrom: Date = Date()) {
        let dateFrom = dateFrom.toString()

        parameters = "?v=3&sort=popularity&asc=0&locale=en&infants=0&flyFrom=prague_cz&to=anywhere&dateFrom=\(dateFrom)&typeFlight=oneway&one_per_date=0&oneforcity=1&adults=1&limit=5&partner=skypicker"
    }
}
