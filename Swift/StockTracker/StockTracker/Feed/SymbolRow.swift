//
//  SymbolRow.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

import SwiftUI

struct SymbolRow: View {
    let symbol: StockSymbol

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(symbol.name)
                    .font(.headline)
            }

            Spacer()
            VStack(alignment: .trailing) {
                Text(String(format: "%.2f", symbol.price))
                    .font(.headline)

                if let hasIncreased = symbol.hasIncreased {
                    Text(hasIncreased ? "↑" : "↓")
                        .font(.subheadline)
                        .foregroundColor(hasIncreased ? .green : .red)
                } else {
                    Text("-").font(.subheadline).foregroundColor(.secondary)
                }
            }
        }
        .padding(.vertical, 6)
    }
}
