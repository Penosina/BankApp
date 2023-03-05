//
//  URLFactory.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct URLFactory {
//	private static let baseURL = "http://185.219.82.59:8765/core/"
	private static let baseURL = "http://localhost:8765/client/"
	private static let authBaseURL = "http://localhost:8765/user/"
	private static let clientId = "952"

	struct Auth {
		static let auth = authBaseURL + "auth"
	}

	struct OperationHistory {
		static let history = baseURL + "history/operations"
	}

	struct BankAccounts {
		static let accounts = baseURL + "account/" + clientId
		static let withdraw = baseURL + "account/withdrawal"
		static let replenish = baseURL + "account/refill"

		static func account(id: String) -> String {
			baseURL + "accounts/\(id)"
		}

		static func close(id: String) -> String {
			baseURL + "account/" + id
		}

		static func operationHistory(id: String) -> String {
			baseURL + "history/operations/" + id
		}
	}

	struct Loans {
		static let loans = baseURL + "loans"
	}
}
