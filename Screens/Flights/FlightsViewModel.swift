//
//  FlightsViewModel.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 18.08.2022.
//

import Foundation

enum ViewModelState {
    case initial
    case loading
    case empty
    case loaded
    case error(String)
}

final class FlightsViewModel {
    
    var state = CurrentValue<ViewModelState>(.initial)
    
    var viewModels: [FlightsItemModel] = []
    
    private var cancellables = Cancellables()

    private let flightsService: FlightsService
    
    init(flightsService: FlightsService) {
        self.flightsService = flightsService
    }

    func loadFilghts() {

        state.send(.loading)
        
        flightsService.fetchFlights()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state.send(.error(error.localizedDescription))
                }
            }, receiveValue: { [weak self] response in
                self?.handleResponse(response)
            })
            .store(in: &cancellables)
    }
}

private extension FlightsViewModel {
    func handleResponse(_ response: FlightsResponse) {
        
        viewModels = response.data.map(FlightsItemModel.init)
        
        state.send(.loaded)
    }
}
