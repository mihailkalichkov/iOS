//
//  FeedViewModel.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation
import Combine

enum FeedConnectionState {
    case connected
    case disconnected
}

final class FeedViewModel: FeedViewModelProtocol {
    let symbolsService: SymbolsService
    
    @Published var symbols = [StockSymbol]()
    @Published var connectionStatusText: String = "Disconnected"
    @Published var isRunning: Bool = false
    @Published var connectionState: FeedConnectionState = .disconnected
    @Published var connectButtonText: String = "Start"
    
    private var cancellables = Set<AnyCancellable>()
    
    init(symbolsService: SymbolsService) {
        self.symbolsService = symbolsService
    }
    
    func onAppear() {
        bindSymbols()
        bindConnectionStatus()
    }
    
    func connectButtonTapped() {
        if symbolsService.isRunning {
            symbolsService.stop()
            isRunning = false
            connectButtonText = "Start"
        } else {
            symbolsService.start()
            isRunning = true
            connectButtonText = "Stop"
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
                connectionState = status == .connected ? .connected : .disconnected
                
                connectionStatusText = switch status {
                case .connected: "Connected"
                case .disconnected: "Disconnected"
                case .connecting: "Connecting..."
                }
            }
            .store(in: &cancellables)
    }
}
