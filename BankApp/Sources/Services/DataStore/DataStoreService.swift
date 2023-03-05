//
//  DataStoreService.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation

final class DataStoreService: DataStoreProtocol {
	private enum Keys: String {
		case tokens
	}

	private let defaults = UserDefaults.standard

	var tokens: AuthTokenPair? {
		get {
			guard let data = defaults.data(forKey: Keys.tokens.rawValue) else { return nil }
			return try? JSONDecoder().decode(AuthTokenPair.self, from: data)
		}
		set {
			let data = (try? JSONEncoder().encode(newValue)) ?? Data()
			defaults.set(data, forKey: Keys.tokens.rawValue)
		}
	}
}
