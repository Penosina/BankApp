//
//  NetworkService+BankAccounts.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import PromiseKit

struct TransferQuery {
	let accountId: String
	let amount: Double
}

extension NetworkService: BankAccountsNetworkProtocol {
	private enum Keys {
		static let accountId = "accountId"
		static let amount = "amount"
	}

	func getAccounts() -> Promise<[BankAccount]> {
		request(method: .get,
				url: URLFactory.BankAccounts.accounts,
				authorized: false)
	}

	func getAccount(with accountId: String) -> Promise<BankAccount> {
		return request(method: .get,
					   url: URLFactory.BankAccounts.account(id: accountId),
					   authorized: false)
	}

	func withdraw(query: TransferQuery) -> Promise<BankAccount> {
		let parameters: [String: Any] = [
			Keys.accountId: query.accountId,
			Keys.amount: query.amount
		]
		return request(method: .post,
					   url: URLFactory.BankAccounts.withdraw,
					   authorized: false,
					   parameters: parameters)
	}

	func replenish(query: TransferQuery) -> Promise<BankAccount> {
		let parameters: [String: Any] = [
			Keys.accountId: query.accountId,
			Keys.amount: query.amount
		]
		return request(method: .post,
					   url: URLFactory.BankAccounts.replenish,
					   authorized: false,
					   parameters: parameters)
	}

	func create() -> Promise<BankAccount> {
		request(method: .post,
				url: URLFactory.BankAccounts.accounts,
				authorized: false)
	}

	func close(accountId: String) -> Promise<EmptyResponse> {
		request(method: .delete,
				url: URLFactory.BankAccounts.close(id: accountId),
				authorized: false)
	}

	func getOperaionHistory(accountId: String) -> Promise<[Operation]> {
		request(method: .get,
				url: URLFactory.BankAccounts.operationHistory(id: accountId),
				authorized: false)
	}
}
