//
//  WebSocketService.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.03.2023.
//

import Foundation
import Starscream

final class WebSocketService {
	private var isConnected = false
	private var socket: WebSocket?
	private let socketURL = URL(string: "ws://echo.websocket.org")
	private let notifier = WebSocketNotifier()

	deinit {
		socket?.disconnect()
		socket = nil
	}

	func register(_ listener: WebSocketListener) {
		notifier.register(listener)
	}

	func unregister(_ listener: WebSocketListener) {
		notifier.unregister(listener)
	}

	func start() {
		guard let socketURL else { return }
		let request = URLRequest(url: socketURL)
		let socket = WebSocket(request: request)
		self.socket = socket
		socket.delegate = self
		socket.connect()
	}

	private func handleError(_ error: Error?) {
		if let error {
			notifier.notifyLoading(with: error)
		} else {
			print("Пришла пустая ошибка")
		}
	}

	private func didReceiveData(_ data: Data) {
		if let operation = try? JSONDecoder().decode(Operation.self, from: data) {
			notifier.notifyDidLoad(operation)
		} else {
			print("Пришли данные: \(data)")
		}
	}
}

extension WebSocketService: WebSocketDelegate {
	func didReceive(event: WebSocketEvent, client: WebSocket) {
		switch event {
		case .connected(let headers):
			isConnected = true
			print("websocket is connected: \(headers)")
		case .disconnected(let reason, let code):
			isConnected = false
			print("websocket is disconnected: \(reason) with code: \(code)")
		case .text(let string):
			print("Received text: \(string)")
		case .binary(let data):
			didReceiveData(data)
		case .ping(_):
			break
		case .pong(_):
			break
		case .viabilityChanged(_):
			break
		case .reconnectSuggested(_):
			break
		case .cancelled:
			isConnected = false
		case .error(let error):
			isConnected = false
			handleError(error)
		}
	}
}
