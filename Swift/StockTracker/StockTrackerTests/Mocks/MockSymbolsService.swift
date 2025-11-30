//
//  MockSymbolsService.swift
//  StockTrackerTests
//
//  Created by Mihail Kalichkov on 30.11.25.
//

@testable import StockTracker
import Combine

final class MockSymbolsService: SymbolsServiceProtocol {
    @Published var symbols: [StockSymbol] = []
    @Published var connectionStatus: WebSocketService.ConnectionState = .disconnected

    var symbolsPublisher: Published<[StockSymbol]>.Publisher { $symbols }
    var connectionStatusPublisher: Published<WebSocketService.ConnectionState>.Publisher { $connectionStatus }

    var isRunning: Bool = false

    private(set) var didCallStart = false
    private(set) var didCallStop = false
    private(set) var didCallPublisher = false

    func start() {
        didCallStart = true
    }

    func stop() {
        didCallStop = true
    }

    func publisher(for name: String) -> AnyPublisher<StockSymbol?, Never> {
        didCallPublisher = true
        
        // Return a simple stub publisher
        return Just(nil).eraseToAnyPublisher()
    }
}
