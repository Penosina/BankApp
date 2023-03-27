//
//  OAuthService.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import PromiseKit

protocol OAuthServiceProtocol: AnyObject {
	func updateSessionCredentials()
}

final class OAuthService: OAuthServiceProtocol {
	private enum Keys: String {
		case token
	}


	private let authService: AuthNetworkProtocol
	private let dataStoreService: DataStoreProtocol

	init(authNetworkProtocol: AuthNetworkProtocol, dataStoreProtocol: DataStoreProtocol) {
		self.authService = authNetworkProtocol
		self.dataStoreService = dataStoreProtocol
	}

	func loginWithRemoteAccount(with deepLinkURL: URL) -> Promise<EmptyResponse> {
		firstly {
			authService.loginWithRemoteAccount(token: getToken(from: deepLinkURL))
		}
		.map { authResponse in
			self.updateTokens(authResponse.tokens)
			return EmptyResponse()
		}
	}

	func updateSessionCredentials() {
		let tokens = dataStoreService.tokens
		authService.updateSessionCredentials(with: tokens)
	}

	private func getToken(from url: URL) -> String? {
		guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return nil }
		let item = urlComponents.queryItems?.first { $0.name == Keys.token.rawValue }
		return item?.value
	}


	private func updateTokens(_ tokens: AuthTokenPair) {
		dataStoreService.tokens = tokens
		authService.updateSessionCredentials(with: tokens)
	}
}

extension OAuthService: OAuthAuthenticatorDelegate {
	func oAuthAuthenticatorDidRequestRefresh(_ oAuthAuthenticator: OAuthAuthenticator,
											 with credential: AuthTokenPair,
											 completion: @escaping (Swift.Result<AuthTokenPair, Error>) -> Void) {
		firstly {
			authService.refresh(refreshToken: credential.refreshToken)
		}.done { tokens in
			self.updateTokens(tokens)
			completion(.success(tokens))
		}.catch { error in
			completion(.failure(error))
		}
	}
}
