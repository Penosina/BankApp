//
//  AuthViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation

//protocol AuthViewModelDelegate: AnyObject {
//	func authViewModelDidFinish()
//}
//
//final class AuthViewModel {
//	typealias Dependencies = HasDataStore & HasOAuthService
//
//	weak var delegate: AuthViewModelDelegate?
//
//	private let dependencies: Dependencies
//
//	init(dependencies: Dependencies) {
//		self.dependencies = dependencies
//	}
//
//	func auth(login: String) {
//		// auth actions
//		dependencies.dataStore.tokens = AuthTokenPair(accessToken: "access token",
//													  accessTokenExpirationTime: 60,
//													  refreshToken: "refresh token",
//													  refreshTokenExpirationTime: 60000)
//		delegate?.authViewModelDidFinish()
//	}
//}

protocol AuthViewModelDelegate: AnyObject {
  func authViewModelDidReceiveDeepLink()
}

final class AuthViewModel {
	typealias Dependencies = HasDeepLinksService

	weak var delegate: AuthViewModelDelegate?

	private let dependencies: Dependencies

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
		dependencies.deepLinksService.subscribe(self)
	}

	deinit {
		dependencies.deepLinksService.unsubscribe(self)
	}
}

extension AuthViewModel: DeepLinkOAuthHandler {
	func handleDeepLink(with url: URL) {
		delegate?.authViewModelDidReceiveDeepLink()
	}
}
