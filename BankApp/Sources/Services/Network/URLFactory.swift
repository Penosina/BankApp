//
//  URLFactory.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct URLFactory {
	private static let baseURL = "http://185.219.82.59:8765/core/"

	struct Auth {
		static let auth = baseURL + "auth"
	}

	struct OperationHistory {
		static let history = baseURL + "history"
	}

	struct BankAccounts {
		static let accounts = baseURL + "accounts"

		static func account(id: String) -> String {
			baseURL + "accounts/\(id)"
		}

		static func withdraw(id: String) -> String {
			baseURL + "accounts/\(id)/" + "withdraw"
		}

		static func replenish(id: String) -> String {
			baseURL + "accounts/\(id)/" + "replenish"
		}

		static func close(id: String) -> String {
			baseURL + "accounts/\(id)/" + "close"
		}

		static func operationHistory(id: String) -> String {
			baseURL + "accounts/\(id)/" + "history"
		}
	}

	struct Loans {
		static let loans = baseURL + "loans"
	}
}
