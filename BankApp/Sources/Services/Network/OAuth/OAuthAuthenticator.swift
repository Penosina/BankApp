//
//  OAuthAuthenticator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Alamofire
import Foundation

protocol OAuthAuthenticatorDelegate: AnyObject {
	func oAuthAuthenticatorDidRequestRefresh(_ oAuthAuthenticator: OAuthAuthenticator,
											 with credential: AuthTokenPair,
											 completion: @escaping (Swift.Result<AuthTokenPair, Error>) -> Void)
}

protocol OAuthAuthenticatorProtocol: AnyObject {
	var delegate: OAuthAuthenticatorDelegate? { get set }
}

final class OAuthAuthenticator: Authenticator, OAuthAuthenticatorProtocol {
	weak var delegate: OAuthAuthenticatorDelegate?

	func apply(_ credential: AuthTokenPair, to urlRequest: inout URLRequest) {
		urlRequest.headers.add(.authorization(bearerToken: credential.accessToken))
	}

	func refresh(_ credential: AuthTokenPair, for session: Alamofire.Session, completion: @escaping (Result<AuthTokenPair, Error>) -> Void) {
		delegate?.oAuthAuthenticatorDidRequestRefresh(self, with: credential, completion: completion)
	}

	func didRequest(_ urlRequest: URLRequest, with response: HTTPURLResponse, failDueToAuthenticationError error: Error) -> Bool {
		response.statusCode == HTTPStatusCode.unauthorized.rawValue
	}

	func isRequest(_ urlRequest: URLRequest, authenticatedWith credential: AuthTokenPair) -> Bool {
		let credentialToken = HTTPHeader.authorization(bearerToken: credential.accessToken).value
		let requestToken = urlRequest.value(forHTTPHeaderField: "Authorization")
		return requestToken == credentialToken
	}
}
