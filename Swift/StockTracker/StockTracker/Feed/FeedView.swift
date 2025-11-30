//
//  FeedView.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

@MainActor protocol FeedViewModelProtocol: ObservableObject {
    var symbols: [StockSymbol] { get }
    var connectionStatusText: String { get }
    var isRunning: Bool { get }
    var connectionState: FeedConnectionState { get }
    var connectButtonText: String { get }
    var symbolsService: SymbolsService { get }
    var selectedSymbol: StockSymbol? { get }
    func onAppear()
    func connectButtonTapped()
    func willNavigateToSymbol(named: String)
}

struct FeedView<ViewModel: FeedViewModelProtocol>: View {
    @EnvironmentObject var router: AppRouter
    @StateObject var viewModel: ViewModel
    @Binding var path: NavigationPath
    
    init(viewModel: ViewModel, path: Binding<NavigationPath>) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _path = path
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                symbolsList
                    .padding()
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
        .toolbar {
            topBar
        }
        .navigationTitle("Prices")
        .navigationDestination(for: StockSymbol.self) { symbol in
            SymbolDetailView(viewModel: SymbolDetailViewModel(symbol: symbol, symbolsService: viewModel.symbolsService))
        }
        .onReceive(router.$deepLinkedSymbol) { symbolName in
            guard let symbolName else { return }
            
            viewModel.willNavigateToSymbol(named: symbolName)
            if let symbol = viewModel.selectedSymbol {
                path.append(symbol)
            }
        }
    }
    
    @ViewBuilder private var topBar: some View {
        HStack {
            connectionIndicator
            Spacer()
            connectButton
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder private var connectButton: some View {
        Button(action: viewModel.connectButtonTapped) {
            Text(viewModel.connectButtonText)
                .bold()
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke())
        }
    }
    
    @ViewBuilder private var connectionIndicator: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundColor(viewModel.connectionState == .connected ? .green : .red)
            Text(viewModel.connectionStatusText)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    @ViewBuilder private var symbolsList: some View {
        ForEach(viewModel.symbols) { symbol in
            NavigationLink(value: symbol) {
                SymbolRow(symbol: symbol)
                    .transition(.slide)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: viewModel.symbols)
    }
}
