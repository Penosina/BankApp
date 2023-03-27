//
//  NetworkService+Loans.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import PromiseKit
import Alamofire

extension NetworkService: LoansNetworkProtocol {
	private enum Keys {
		static let loanPeriod = "loanPeriod"
		static let loanAmount = "loanAmount"
		static let accountDebitingId = "accountDebitingId"
		static let accountReplenishmentId = "accountReplenishmentId"
		static let loanId = "id"
		static let amount = "amount"
		static let accountId = "accountId"
		static let rateId = "rateId"
		static let clientId = "clientId"
	}

	func getLoans() -> Promise<[Loan]> {
		request(method: .get,
				url: URLFactory.Loans.loans,
				authorized: true)
	}

	func repay(query: RepayLoanQuery) -> Promise<RepaymentModel> {
		let parameters: Parameters = [
			Keys.loanId: query.loanId,
			Keys.amount: query.amount,
			Keys.accountId: query.accountId
		]
		return request(method: .post,
					   url: URLFactory.Loans.repay,
					   authorized: true,
					   parameters: parameters)
	}

	func create(query: CreateLoanQuery) -> Promise<Loan> {
		let parameters: Parameters = [
			Keys.loanPeriod: query.loanPeriod,
			Keys.loanAmount: query.loanAmount,
			Keys.accountDebitingId: query.accountDebitingId,
			Keys.accountReplenishmentId: query.accountReplenishmentId,
			Keys.rateId: 1001,
			Keys.clientId: 1103
		]
		return request(method: .post,
					   url: URLFactory.Loans.create,
					   authorized: true,
					   parameters: parameters)
	}
}

struct CreateLoanQuery {
	let loanPeriod: Int
	let loanAmount: Double
	let accountDebitingId: Int64
	let accountReplenishmentId: Int64
}

struct RepayLoanQuery {
	let loanId: Int64
	let amount: Double
	let accountId: Int64
}
