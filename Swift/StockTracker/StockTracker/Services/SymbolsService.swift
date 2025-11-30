//
//  SymbolsService.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation
import Combine

protocol SymbolsServiceProtocol: ObservableObject {
    var symbols: [StockSymbol] { get }
    var symbolsPublisher: Published<[StockSymbol]>.Publisher { get }
    var isRunning: Bool { get }
    var connectionStatus: WebSocketService.ConnectionState { get }
    var connectionStatusPublisher: Published<WebSocketService.ConnectionState>.Publisher { get }
    
    func start()
    func stop()
    func publisher(for name: String) -> AnyPublisher<StockSymbol?, Never>
}

final class SymbolsService: SymbolsServiceProtocol {
    @Published private(set) var symbols = [StockSymbol]()
    @Published var isRunning = false
    @Published var connectionStatus = WebSocketService.ConnectionState.disconnected
    
    var symbolsPublisher: Published<[StockSymbol]>.Publisher { $symbols }
    var connectionStatusPublisher: Published<WebSocketService.ConnectionState>.Publisher { $connectionStatus }
    
    private var cancellables = Set<AnyCancellable>()
    private let websocketManager = WebSocketService.shared
    private var timerCancellable: AnyCancellable?
    
    private let updateInterval: TimeInterval = 2.0
    private let symbolNames: [String] = [
        "AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","META","INTC","AMD","NFLX",
        "BABA","ORCL","IBM","ADBE","CRM","SAP","QCOM","AVGO","TXN","ASML",
        "SONY","SBUX","NKE","DIS","UBER"
    ]
    
    init() {
        resetSymbols()
        bindWebSocket()
        bindConnectionState()
    }
    
    func start() {
        guard !isRunning else { return }
        websocketManager.connect()
        isRunning = true

        updatePrices()
    }

    func stop() {
        guard isRunning else { return }
        isRunning = false
        timerCancellable?.cancel()
        timerCancellable = nil
        websocketManager.disconnect()
    }
    
    func publisher(for name: String) -> AnyPublisher<StockSymbol?, Never> {
        $symbols
            .map { symbols in
                let symbol = symbols.first(where: { $0.name == name })
                return symbol
            }
            .removeDuplicates { lhs, rhs in
                switch (lhs, rhs) {
                case (nil, nil):
                    return true
                case let (l?, r?):
                    return l.price == r.price
                default:
                    return false
                }
            }
            .eraseToAnyPublisher()
    }
    
    private func updatePrices() {
        timerCancellable = Timer.publish(every: updateInterval, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                symbols.forEach { symbol in
                    let newPrice = self.randomChange(from: symbol.price)
                    let message = "\(symbol.name):\(String(format: "%.2f", newPrice))"
                    self.websocketManager.send(text: message)
                }
            }
    }
    
    private func resetSymbols() {
        symbols = symbolNames.map { StockSymbol(name: $0, price: randomStartingPrice()) }
        sortSymbols()
    }

    private func bindWebSocket() {
        websocketManager.messageSubject
            .receive(on: DispatchQueue.main)
            .sink { [weak self] message in
                self?.handleMessage(message)
            }
            .store(in: &cancellables)
    }

    private func bindConnectionState() {
        websocketManager.$state
            .receive(on: DispatchQueue.main)
            .assign(to: \.connectionStatus, on: self)
            .store(in: &cancellables)
    }
    
    private func randomStartingPrice() -> Double {
        Double.random(in: 10...1500).rounded(toPlaces: 2)
    }
    
    private func randomChange(from price: Double) -> Double {
        let pctChange = Double.random(in: -0.03...0.03)
        let newPrice = max(0.01, price * (1 + pctChange))
        return newPrice.rounded(toPlaces: 2)
    }
    
    private func handleMessage(_ message: String) {
        let cleaned = message.trimmingCharacters(in: .whitespacesAndNewlines)
        let components = cleaned.components(separatedBy: ":")
        guard components.count >= 2 else { return }
        let symbol = components[0]
        
        var priceString = components[1...].joined(separator: ":")
        priceString = priceString.replacingOccurrences(of: "\"", with: "")
        guard let price = Double(priceString) else { return }

        update(symbol: symbol, price: price)
    }
    
    private func update(symbol: String, price: Double) {
        guard let idx = symbols.firstIndex(where: { $0.name == symbol }) else { return }
        var item = symbols[idx]
        item.previousPrice = item.price
        item.price = price
        if let previousPrice = item.previousPrice, price != previousPrice {
            item.hasIncreased = price > previousPrice
        } else {
            item.hasIncreased = nil
        }
        
        symbols[idx] = item

        sortSymbols()
    }
    
    private func sortSymbols() {
        symbols.sort { $0.price > $1.price }
    }
}

private extension Double {
    func rounded(toPlaces places: Int) -> Double {
        let mult = pow(10.0, Double(places))
        return (self * mult).rounded() / mult
    }
}
