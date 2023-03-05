//
//  AuthViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation

protocol AuthViewModelDelegate: AnyObject {
	func authViewModelDidFinish()
}

final class AuthViewModel {
	typealias Dependencies = HasDataStore & HasNetworkService

	weak var delegate: AuthViewModelDelegate?

	private let dependencies: Dependencies

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}

	func auth(login: String) {
		// auth actions
		dependencies.dataStore.tokens = AuthTokenPair(accessToken: "access token",
													  accessTokenExpirationTime: 60,
													  refreshToken: "refresh token",
													  refreshTokenExpirationTime: 60000)
		delegate?.authViewModelDidFinish()
	}
}
