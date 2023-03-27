//
//  DeepLinksService.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 25.03.2023.
//

protocol DeepLinksServiceProtocol: AnyObject {
	func subscribe(_ handler: DeepLinkHandler)
	func unsubscribe(_ handler: DeepLinkHandler)
	func notify(deepLink: DeepLink)
}

final class DeepLinksService: DeepLinksServiceProtocol {
	private var deepLinkHandlers: [DeepLinkHandler]

	init() {
		deepLinkHandlers = []
	}

	func subscribe(_ handler: DeepLinkHandler) {
		deepLinkHandlers.append(handler)
	}

	func unsubscribe(_ handler: DeepLinkHandler) {
		deepLinkHandlers.removeAll { $0 === handler }
	}

	func notify(deepLink: DeepLink) {
		switch deepLink {
		case .oAuth(let url):
			deepLinkHandlers
			.compactMap { $0 as? DeepLinkOAuthHandler }
			.forEach { $0.handleDeepLink(with: url) }
		}
	}
}
