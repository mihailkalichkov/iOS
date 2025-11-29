//
//  WebSocketService.swift
//  StockTracker
//
//  Created by Mihail Kalichkov on 29.11.25.
//

import Foundation
import Combine

final class WebSocketService {
    static let shared = WebSocketService()
    private init() {}

    private var task: URLSessionWebSocketTask?
    private let url = URL(string: "wss://ws.postman-echo.com/raw")!
    private var receiveCancellable: AnyCancellable?

    enum ConnectionState {
        case disconnected
        case connecting
        case connected
    }

    @Published private(set) var state: ConnectionState = .disconnected

    let messageSubject = PassthroughSubject<String, Never>()

    private let queue = DispatchQueue(label: "websocket.manager", qos: .userInitiated)

    func connect() {
        queue.async { [weak self] in
            guard let self = self else { return }
            if self.task != nil { return }
            self.state = .connecting

            let urlSession = URLSession(configuration: .default)
            self.task = urlSession.webSocketTask(with: self.url)
            self.task?.resume()
            self.state = .connected

            self.receiveLoop()
        }
    }

    func disconnect() {
        queue.async { [weak self] in
            guard let self = self else { return }
            self.task?.cancel(with: .goingAway, reason: nil)
            self.task = nil
            self.state = .disconnected
        }
    }

    func send(text: String) {
        queue.async { [weak self] in
            guard let self = self, let task = self.task else { return }
            let message = URLSessionWebSocketTask.Message.string(text)
            task.send(message) { error in
                if let e = error {
                    print("WebSocket send error:", e)
                }
            }
        }
    }

    private func receiveLoop() {
        task?.receive { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let err):
                print("WebSocket receive failure:", err)
                self.handleDisconnect()
            case .success(let message):
                switch message {
                case .string(let text):
                    self.messageSubject.send(text)
                case .data(let data):
                    if let text = String(data: data, encoding: .utf8) {
                        self.messageSubject.send(text)
                    }
                @unknown default:
                    break
                }
                
                self.receiveLoop()
            }
        }
    }

    private func handleDisconnect() {
        self.task?.cancel()
        self.task = nil
        self.state = .disconnected
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.connect()
        }
    }
}
