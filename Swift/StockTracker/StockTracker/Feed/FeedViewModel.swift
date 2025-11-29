//
//  FeedViewModel.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation
import Combine

final class FeedViewModel: FeedViewModelProtocol {
    @Published var symbols: [String] = [
        "AAPL","GOOG","TSLA","AMZN","MSFT","NVDA","META","INTC","AMD","NFLX",
        "BABA","ORCL","IBM","ADBE","CRM","SAP","QCOM","AVGO","TXN","ASML",
        "SONY","SBUX","NKE","DIS","UBER"
    ]
    
    @Published var connectionStatusText: String = "Disconnected"
    
    func onAppear() {
        
    }
    
    func connectButtonTapped() {
        
    }
}
