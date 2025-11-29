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
    func onAppear()
    func connectButtonTapped()
}

struct FeedView<ViewModel: FeedViewModelProtocol>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        LazyVStack {
            topBar
            symbolsList
        }
        .padding()
        .onAppear {
            viewModel.onAppear()
        }
    }
    
    private var topBar: some View {
        HStack {
            connectionIndicator
            Spacer()
            connectButton
        }
    }
    
    private var connectButton: some View {
        Button(action: viewModel.connectButtonTapped) {
            Text(viewModel.connectButtonText)
                .bold()
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke())
        }
    }
    
    private var connectionIndicator: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundColor(viewModel.connectionState == .connected ? .green : .red)
            Text(viewModel.connectionStatusText)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var symbolsList : some View {
        ForEach(viewModel.symbols) { symbol in
            HStack {
                Text(symbol.name)
                Text("\(symbol.price)")
            }
        }
    }
}
