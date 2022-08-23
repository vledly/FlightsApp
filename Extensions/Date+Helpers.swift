//
//  Date+Helpers.swift
//  FlightsApp (iOS)
//
//  Created by Vladislav Meleshko on 23.08.2022.
//

import Foundation

extension Date {
    func toString(format: String = "dd/MM/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
