//
//  SymbolRow.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

struct SymbolRow: View {
    let symbol: StockSymbol
    
    @State private var isFlashing: Bool = false
    
    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading) {
                Text(symbol.name)
                    .font(.headline)
            }
            
            Spacer()
            HStack() {
                Text(String(format: "%.2f", symbol.price))
                    .font(.headline)
                    .foregroundStyle(isFlashing ? priceColor : .primary)
                    .animation(.default, value: isFlashing)
                
                if let hasIncreased = symbol.hasIncreased {
                    Text(hasIncreased ? "↑" : "↓")
                        .font(.subheadline)
                        .foregroundColor(hasIncreased ? .green : .red)
                        .animation(.default, value: isFlashing)
                } else {
                    Text("-").font(.subheadline).foregroundColor(.secondary)
                }
            }
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.primary)
                .opacity(isFlashing ? 1 : 0.6)
                .animation(.easeInOut(duration: 0.2), value: isFlashing)
        }
        .onChange(of: symbol.price) { _, _ in
            isFlashing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isFlashing = false
            }
        }
    }
    
    var priceColor: Color {
        guard let hasIncreased = symbol.hasIncreased else { return .primary }
        return hasIncreased ? .green : .red
    }
}
