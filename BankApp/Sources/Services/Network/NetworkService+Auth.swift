//
//  NetworkService+Auth.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import PromiseKit

extension NetworkService: AuthNetworkProtocol {
	func refresh(refreshToken: String) -> Promise<AuthTokenPair> {
		request(method: .post,
				url: "refresh",
				headers: [.authorization(bearerToken: refreshToken)])
	}

	func updateSessionCredentials(with tokens: AuthTokenPair?) {
		authInterceptor.credential = tokens
	}
}
