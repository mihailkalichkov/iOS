//
//  SymbolDetailView.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

@MainActor protocol SymbolDetailViewModelProtocol: ObservableObject {
    var name: String { get }
    var price: Double { get }
    var description: String { get }
    var hasIncreased: Bool? { get }
}

struct SymbolDetailView<ViewModel: SymbolDetailViewModelProtocol>: View {
    @StateObject var viewModel: ViewModel
    
    @State private var isFlashing: Bool = false
    
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.name)
                .font(.largeTitle)
                .bold()
            
            HStack {
                Text(String(format: "%.2f", viewModel.price))
                    .font(.title)
                    .foregroundStyle(isFlashing ? priceColor : .primary)
                    .animation(.default, value: isFlashing)
                
                if let hasIncreased = viewModel.hasIncreased {
                    Text(hasIncreased ? "↑" : "↓")
                        .font(.subheadline)
                        .foregroundColor(hasIncreased ? .green : .red)
                        .animation(.default, value: isFlashing)
                } else {
                    Text("-").font(.subheadline).foregroundColor(.secondary)
                }
            }
            
            Text(viewModel.description)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
        .onChange(of: viewModel.price) { _, _ in
            guard !isFlashing else { return }
            isFlashing = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                isFlashing = false
            }
        }
    }
    
    var priceColor: Color {
        guard let hasIncreased = viewModel.hasIncreased else { return .primary }
        return hasIncreased ? .green : .red
    }
}
