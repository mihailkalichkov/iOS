//
//  FeedViewModel.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation
import Combine

final class FeedViewModel: FeedViewModelProtocol {
    private var cancellables = Set<AnyCancellable>()
    private var symbolsService = SymbolsService()
    
    @Published var symbols = [StockSymbol]()
    @Published var connectionStatusText: String = "Disconnected"
    @Published var isRunning: Bool = false
    
    func onAppear() {
        bindSymbols()
        bindConnectionStatus()
    }
    
    func connectButtonTapped() {
        if symbolsService.isRunning {
            symbolsService.stop()
            isRunning = false
        } else {
            symbolsService.start()
            isRunning = true
        }
    }
    
    private func bindSymbols() {
        symbolsService
            .$symbols
            .receive(on: DispatchQueue.main)
            .assign(to: \.symbols, on: self)
            .store(in: &cancellables)
    }
    
    private func bindConnectionStatus() {
        symbolsService.$connectionStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                guard let self else { return }
                
                connectionStatusText = switch status {
                case .connected: "Connected"
                case .disconnected: "Disconnected"
                case .connecting: "Connecting..."
                }
            }
            .store(in: &cancellables)
    }
}
