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
}

struct SymbolDetailView<ViewModel: SymbolDetailViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Text(viewModel.name)
                .font(.largeTitle)
                .bold()
            
            HStack {
                Text(String(format: "%.2f", viewModel.price))
                    .font(.title)
            }
            
            Text(viewModel.description)
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Detail")
    }
}
