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
	private static let clientId = "1103"

	struct Auth {
		static let auth = authBaseURL + "auth"
	}

	struct BankAccounts {
		static let accounts = baseURL + "account/" + clientId + "/client"
		static let accountsToTransfer = baseURL + "account/" + clientId + "/client"
		static let create = baseURL + "account/" + clientId
		static let withdraw = baseURL + "account/withdrawal"
		static let replenish = baseURL + "account/refill"
		static let makeTransfer = baseURL + "account/make-transfer"

		static func account(id: Int64) -> String {
			baseURL + "account/" + "\(id)"
		}

		static func close(id: Int64) -> String {
			baseURL + "account/" + "\(id)"
		}

		static func operationHistory(id: Int64) -> String {
			baseURL + "history/operations/" + "\(id)"
		}
	}

	struct Loans {
		static let create = baseURL + "loan"
		static let loans = baseURL + "loan/" + clientId + "/client"
		static let repay = baseURL + "loan/repay"
	}
}
