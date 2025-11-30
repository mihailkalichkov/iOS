//
//  StockTrackerApp.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

@main
struct StockTrackerApp: App {
    @StateObject var router = AppRouter()
    @State private var path = NavigationPath()
    private var symbolsService = SymbolsService()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $path,
                            root: {
                FeedView(viewModel: FeedViewModel(symbolsService: symbolsService), path: $path)
                    .environmentObject(router)
            })
            .onOpenURL { url in
                router.handle(url: url)
            }
        }
    }
}
