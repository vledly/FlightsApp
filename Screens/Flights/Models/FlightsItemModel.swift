//
//  FlightsItemModel.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import UIKit
import Combine

final class FlightsItemModel: Hashable, FlightItemCellPresentable {

    let title: String
    let flyDuration: String
    let price: String
    let imageUrl: URL?
    
    private let identifier = UUID()

    init(flight: FlightsResponse.Flight) {
        title = "\(flight.cityFrom) - \(flight.cityTo)"
        flyDuration = flight.flyDuration
        price = "\(flight.price) EUR"
        imageUrl = URL(string: "https://images.kiwi.com/photos/600x330/\(flight.id)")
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }

    static func == (lhs: FlightsItemModel, rhs: FlightsItemModel) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
