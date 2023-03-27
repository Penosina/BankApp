//
//  NetworkService+Auth.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import PromiseKit

extension NetworkService: AuthNetworkProtocol {
	private struct Keys {
		static let token = "token"
	}

	func loginWithRemoteAccount(token: String?) -> Promise<AuthResponse> {
		let parameters = [
			Keys.token: token ?? ""
		]
		return request(method: .post,
					   url: URLFactory.Auth.auth,
					   parameters: parameters)

	}

	func refresh(refreshToken: String) -> Promise<AuthTokenPair> {
		request(method: .post,
				url: "refresh",
				authorized: true,
				headers: [.authorization(bearerToken: refreshToken)])
	}

	func updateSessionCredentials(with tokens: AuthTokenPair?) {
		authInterceptor.credential = tokens
	}
}
