//
//  WebSocketNotifier.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.03.2023.
//

import Foundation

protocol WebSocketListener: AnyObject {
	func didLoad(operation: Operation)
	func errorLoadingOperation(_ error: Error)
}

final class WebSocketNotifier {
	private var listeners: [WebSocketListener] = []

	func register(_ listener: WebSocketListener) {
		listeners.append(listener)
	}

	func unregister(_ listener: WebSocketListener) {
		listeners.removeAll(where: { $0 === listener })
	}

	func notifyDidLoad(_ operation: Operation) {
		listeners.forEach { $0.didLoad(operation: operation)}
	}

	func notifyLoading(with error: Error) {
		listeners.forEach { $0.errorLoadingOperation(error) }
	}
}
