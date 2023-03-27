//
//  AppDependency.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation
import Alamofire

protocol HasDataStore {
	var dataStore: DataStoreProtocol { get }
}

protocol HasBankAccountsService: AnyObject {
	var bankAccountsService: BankAccountsNetworkProtocol { get }
}

protocol HasLoansService: AnyObject {
	var loansService: LoansNetworkProtocol { get }
}

protocol HasOAuthService: AnyObject {
	var oAuthService: OAuthServiceProtocol & OAuthAuthenticatorDelegate { get }
}

protocol HasOAuthAuthenticator: AnyObject {
	var authenticator: OAuthAuthenticatorProtocol { get }
}

protocol HasDeepLinksService: AnyObject {
	var deepLinksService: DeepLinksServiceProtocol { get }
}

protocol HasWebSocketService: AnyObject {
	var webSocketService: WebSocketService { get }
}

final class AppDependency: HasOAuthService, HasDeepLinksService, HasWebSocketService {
	let oAuthService: OAuthServiceProtocol & OAuthAuthenticatorDelegate
	let deepLinksService: DeepLinksServiceProtocol
	let webSocketService: WebSocketService

	private let dataStoreService: DataStoreService
	private let oAuthAuthenticator: OAuthAuthenticator
	private let authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>
	private let networkService: NetworkService

	init() {
		webSocketService = WebSocketService()
		deepLinksService = DeepLinksService()
		dataStoreService = DataStoreService()
		oAuthAuthenticator = OAuthAuthenticator()
		authInterceptor = AuthenticationInterceptor(authenticator: oAuthAuthenticator)
		networkService = NetworkService(authInterceptor: authInterceptor)
		oAuthService = OAuthService(authNetworkProtocol: networkService, dataStoreProtocol: dataStoreService)
	}
}

extension AppDependency: HasDataStore {
	var dataStore: DataStoreProtocol {
		dataStoreService
	}
}

extension AppDependency: HasOAuthAuthenticator {
	var authenticator: OAuthAuthenticatorProtocol {
		oAuthAuthenticator
	}
}

extension AppDependency: HasBankAccountsService {
	var bankAccountsService: BankAccountsNetworkProtocol {
		networkService
	}
}

extension AppDependency: HasLoansService {
	var loansService: LoansNetworkProtocol {
		networkService
	}
}
