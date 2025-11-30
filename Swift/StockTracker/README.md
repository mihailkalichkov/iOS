# 📈 StockTracker

A lightweight real-time stock price tracker built using **SwiftUI**,
**Combine**, and a **WebSocket** echo server.

## 🚀 Features

-   Real-time price updates via WebSocket
-   MVVM architecture
-   Programmatic navigation with NavigationStack
-   Deep link support: stocks://symbol/{SYMBOL}
-   Animated price changes

## 🧭 Deep Links

Example:

    stocks://symbol/AAPL

## ▶️ Run

    xcrun simctl openurl booted "stocks://symbol/AAPL"
