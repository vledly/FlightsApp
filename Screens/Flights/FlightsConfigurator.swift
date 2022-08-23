//
//  FlightsConfigurator.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 18.08.2022.
//

import Foundation

struct FlightsConfigurator {
    static func configure() -> FlightsViewController {
        let networkService = NetworkService()
        let flightsService = FlightsService(service: networkService)
        let viewModel = FlightsViewModel(flightsService: flightsService)
        let viewController = FlightsViewController(viewModel: viewModel)
        
        
        return viewController
    }
}
