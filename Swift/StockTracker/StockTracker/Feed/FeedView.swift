//
//  FeedView.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

@MainActor protocol FeedViewModelProtocol: ObservableObject {
    var symbols: [String] { get }
    var connectionStatusText: String { get }
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
            Text("Start")
                .bold()
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 8).stroke())
        }
    }
    
    private var connectionIndicator: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 12, height: 12)
                .foregroundColor(.green)
            Text(viewModel.connectionStatusText)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
    
    private var symbolsList : some View {
        ForEach(viewModel.symbols, id: \.self) { symbol in
            Text(symbol)
        }
    }
}
