//
//  NetworkService+BankAccounts.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import PromiseKit
import Alamofire

struct TransferQuery {
	let accountId: Int64
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

	func getAccount(accountId: Int64) -> Promise<BankAccount> {
		request(method: .get,
				url: URLFactory.BankAccounts.account(id: accountId),
				authorized: false)
	}

	func withdraw(query: TransferQuery) -> Promise<BankAccount> {
		let parameters: Parameters = [
			Keys.accountId: query.accountId,
			Keys.amount: query.amount
		]
		return request(method: .post,
					   url: URLFactory.BankAccounts.withdraw,
					   authorized: false,
					   parameters: parameters)
	}

	func replenish(query: TransferQuery) -> Promise<BankAccount> {
		let parameters: Parameters = [
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

	func close(accountId: Int64) -> Promise<EmptyResponse> {
		request(method: .delete,
				url: URLFactory.BankAccounts.close(id: accountId),
				authorized: false)
	}

	func getOperaionHistory(accountId: Int64) -> Promise<[Operation]> {
		request(method: .get,
				url: URLFactory.BankAccounts.operationHistory(id: accountId),
				authorized: false)
	}
}
