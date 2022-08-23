//
//  FlightsResponse.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 19.08.2022.
//

import Foundation

struct FlightsResponse: Decodable {

    struct Country: Decodable {
        let code: String
        let name: String
    }

    struct Flight: Decodable {
        let id: String
        let flyFrom: String
        let flyTo: String
        let cityFrom: String
        let cityCodeFrom: String
        let cityTo: String
        let countryFrom: Country
        let countryTo: Country
        let dTime: Int
        let dTimeUTC: Int
        let aTime: Int
        let aTimeUTC: Int
        let quality: Double
        let popularity: Int
        let distance: Double
        let flyDuration: String
        let price: Int
    }

    let data: [Flight]
}
