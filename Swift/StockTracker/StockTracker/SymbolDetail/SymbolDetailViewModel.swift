//
//  SymbolDetailViewModel.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation
import Combine

final class SymbolDetailViewModel: SymbolDetailViewModelProtocol {
    
    var name: String
    @Published var price: Double
    @Published var hasIncreased: Bool?
    var description: String
    
    private var cancellables = Set<AnyCancellable>()
    
    init(symbol: StockSymbol, symbolsService: SymbolsService) {
        self.name = symbol.name
        _price = .init(initialValue: symbol.price)
        _hasIncreased = .init(initialValue: nil)
        self.description = "lorem ipsum"
        
        bindSymbol(symbolsService: symbolsService)
    }
    
    private func bindSymbol(symbolsService: SymbolsService) {
        symbolsService.publisher(for: name)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] symbol in
                guard let self, let symbol else { return }
                hasIncreased = symbol.hasIncreased
                price = symbol.price
            }
            .store(in: &cancellables)
    }
}
