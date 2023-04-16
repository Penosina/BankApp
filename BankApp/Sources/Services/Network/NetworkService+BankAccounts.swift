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

struct MakeBankAccountTransferQuery {
	let amount: Double
	let accountDebitingId: Int64
	let accountReplenishmentId: Int64
}

extension NetworkService: BankAccountsNetworkProtocol {
	private enum Keys {
		static let accountId = "accountId"
		static let amount = "amount"
		static let accountDebitingId = "accountDebitingId"
		static let accountReplenishmentId = "accountReplenishmentId"
	}

	func getAccounts() -> Promise<[BankAccount]> {
		request(method: .get,
				url: URLFactory.BankAccounts.accounts)
	}

	func getAccountsToTransfer() -> Promise<[BankAccount]> {
		request(method: .get,
				url: URLFactory.BankAccounts.accountsToTransfer)
	}

	func getAccount(accountId: Int64) -> Promise<BankAccount> {
		request(method: .get,
				url: URLFactory.BankAccounts.account(id: accountId))
	}

	func withdraw(query: TransferQuery) -> Promise<EmptyResponse> {
		let parameters: Parameters = [
			Keys.accountId: query.accountId,
			Keys.amount: query.amount
		]
		return request(method: .post,
					   url: URLFactory.BankAccounts.withdraw,
					   parameters: parameters)
	}

	func replenish(query: TransferQuery) -> Promise<EmptyResponse> {
		let parameters: Parameters = [
			Keys.accountId: query.accountId,
			Keys.amount: query.amount
		]
		return request(method: .post,
					   url: URLFactory.BankAccounts.replenish,
					   parameters: parameters)
	}

	func makeTransfer(query: MakeBankAccountTransferQuery) -> Promise<BankAccount> {
		let parameters: Parameters = [
			Keys.accountDebitingId: query.accountDebitingId,
			Keys.accountReplenishmentId: query.accountReplenishmentId,
			Keys.amount: query.amount
		]
		return request(method: .post,
					   url: URLFactory.BankAccounts.makeTransfer,
					   parameters: parameters)
	}

	func create() -> Promise<BankAccount> {
		request(method: .post,
				url: URLFactory.BankAccounts.create)
	}

	func close(accountId: Int64) -> Promise<EmptyResponse> {
		request(method: .delete,
				url: URLFactory.BankAccounts.close(id: accountId))
	}

	func getOperaionHistory(accountId: Int64) -> Promise<[Operation]> {
		request(method: .get,
				url: URLFactory.BankAccounts.operationHistory(id: accountId))
	}
}
