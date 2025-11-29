//
//  StockSymbol.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation

struct StockSymbol: Identifiable, Equatable, Hashable {
    let id: String
    let name: String
    var price: Double
    var previousPrice: Double?
    var hasIncreased: Bool?

    init(name: String, price: Double = 0.0) {
        self.name = name
        self.id = name
        self.price = price
        self.hasIncreased = nil
    }
}
