//
//  AppRouter.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 30.11.25.
//

import Foundation
import Combine

import Combine

final class AppRouter: ObservableObject {
    @Published var deepLinkedSymbol: String?

    func handle(url: URL) {
        guard url.scheme == "stocks" else { return }

        let host = url.host
        let pathComponents = url.pathComponents

        if host == "symbol", pathComponents.count > 1 {
            let symbol = pathComponents[1].uppercased()
            deepLinkedSymbol = symbol
        }
    }
}
