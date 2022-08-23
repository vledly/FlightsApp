//
//  StateType.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import Foundation

enum StateType {
    case loading
    case empty
    case error(String)

    var message: String {
        switch self {
        case .loading:
            return "loading ..."
        case .empty:
            return "List is empty :("
        case .error(let string):
            return "WRNING: \(string)"
        }
    }
}
