//
//  Combine+Helpers.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 18.08.2022.
//

import Combine

typealias Cancellables = Set<AnyCancellable>
typealias Passthrough<Value> = PassthroughSubject<Value, Never>
typealias CurrentValue<Value> = CurrentValueSubject<Value, Never>
