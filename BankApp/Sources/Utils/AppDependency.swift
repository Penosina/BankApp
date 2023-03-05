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

protocol HasNetworkService: AnyObject {
	var bankService: NetworkServiceProtocol { get }
}

protocol HasBankAccountsService: AnyObject {
	var bankAccountsService: BankAccountsNetworkProtocol { get }
}

protocol HasOAuthService: AnyObject {
	var oAuthService: OAuthServiceProtocol & OAuthAuthenticatorDelegate { get }
}

protocol HasOAuthAuthenticator: AnyObject {
	var authenticator: OAuthAuthenticatorProtocol { get }
}

final class AppDependency: HasOAuthService {
	let oAuthService: OAuthServiceProtocol & OAuthAuthenticatorDelegate

	private let dataStoreService: DataStoreService
	private let oAuthAuthenticator: OAuthAuthenticator
	private let authInterceptor: AuthenticationInterceptor<OAuthAuthenticator>
	private let networkService: NetworkService

	init() {
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

extension AppDependency: HasNetworkService {
	var bankService: NetworkServiceProtocol {
		networkService
	}
}

extension AppDependency: HasBankAccountsService {
	var bankAccountsService: BankAccountsNetworkProtocol {
		networkService
	}
}
