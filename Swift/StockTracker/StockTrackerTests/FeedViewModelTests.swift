//
//  FeedViewModelTests.swift
//  StockTrackerTests
//
//  Created by Mihail Kalichkov on 30.11.25.
//

import Testing
@testable import StockTracker
import Combine

@Suite
@MainActor
struct FeedViewModelTests {
    
    private func makeSUT(symbolsService: any SymbolsServiceProtocol = MockSymbolsService()) -> FeedViewModel {
        FeedViewModel(symbolsService: symbolsService)
    }

    @Test func testOnAppear() async throws {
        // Given
        let symbolsService = MockSymbolsService()
        let sut = makeSUT(symbolsService: symbolsService)
        let firstValueTask = Task {
            await symbolsService.symbolsPublisher.firstValue()
        }
        
        // When
        symbolsService.symbols = [StockSymbol(name: "AAPL", price: 100)]
        symbolsService.connectionStatus = .connected
        sut.onAppear()
        
        // Then
        _ = await firstValueTask.value
        let symbol = try #require(sut.symbols.first)
        #expect(sut.symbols.count == 1)
        #expect(symbol.name == "AAPL")
        #expect(sut.connectionState == .connected)
    }
    
    @Test func testConnectButtonTappedWhenDisconnected() async throws {
        // Given
        let symbolsService = MockSymbolsService()
        let sut = makeSUT(symbolsService: symbolsService)
        
        // When
        symbolsService.isRunning = false
        sut.connectButtonTapped()
        
        // Then
        #expect(symbolsService.didCallStart)
        #expect(sut.isRunning)
        #expect(sut.connectButtonText == "Stop")
    }
    
    @Test func testConnectButtonTappedWhenConnected() async throws {
        // Given
        let symbolsService = MockSymbolsService()
        let sut = makeSUT(symbolsService: symbolsService)
        
        // When
        symbolsService.isRunning = true
        sut.connectButtonTapped()
        
        // Then
        #expect(symbolsService.didCallStop)
        #expect(!sut.isRunning)
        #expect(sut.connectButtonText == "Start")
    }
    
    @Test func willNavigateToSymbolWhenConnected() async throws {
        // Given
        let symbolsService = MockSymbolsService()
        let sut = makeSUT(symbolsService: symbolsService)
        let symbol = StockSymbol(name: "AAPL", price: 100)
        let firstValueTask = Task {
            await symbolsService.symbolsPublisher.firstValue()
        }
        
        // When
        symbolsService.isRunning = true
        symbolsService.symbols = [symbol]
        symbolsService.connectionStatus = .connected
        sut.onAppear()
        _ = await firstValueTask.value
        sut.willNavigateToSymbol(named: symbol.name)
        
        // Then
        #expect(sut.selectedSymbol == symbol)
        #expect(sut.isRunning)
    }
    
    @Test func willNavigateToSymbolWhenDisconnected() async throws {
        // Given
        let symbolsService = MockSymbolsService()
        let sut = makeSUT(symbolsService: symbolsService)
        let symbol = StockSymbol(name: "AAPL", price: 100)
        let firstValueTask = Task {
            await symbolsService.symbolsPublisher.firstValue()
        }
        
        // When
        symbolsService.isRunning = false
        symbolsService.symbols = [symbol]
        symbolsService.connectionStatus = .disconnected
        sut.onAppear()
        _ = await firstValueTask.value
        sut.willNavigateToSymbol(named: symbol.name)
        
        // Then
        #expect(sut.selectedSymbol == symbol)
        #expect(sut.isRunning)
    }
}

import Foundation

extension Publisher where Failure == Never {
    /// Awaits the first emitted value from the publisher and then cancels subscription.
    func firstValue() async -> Output {
        await withCheckedContinuation { (continuation: CheckedContinuation<Output, Never>) in
            var cancellable: AnyCancellable?
            cancellable = self.sink { value in
                cancellable?.cancel()
                continuation.resume(returning: value)
            }
        }
    }
}
