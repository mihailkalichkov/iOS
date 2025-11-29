//
//  StockTrackerApp.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import SwiftUI

@main
struct StockTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                FeedView(viewModel: FeedViewModel())
            }
        }
    }
}
