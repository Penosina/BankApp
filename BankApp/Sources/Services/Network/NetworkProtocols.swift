//
//  NetworkProtocols.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import PromiseKit

protocol AuthNetworkProtocol {
	func loginWithRemoteAccount(token: String?) -> Promise<AuthResponse>
	func refresh(refreshToken: String) -> Promise<AuthTokenPair>
	func updateSessionCredentials(with tokens: AuthTokenPair?)
}

protocol BankAccountsNetworkProtocol {
	func getAccounts() -> Promise<[BankAccount]>
	func getAccountsToTransfer() -> Promise<[BankAccount]>
	func getAccount(accountId: Int64) -> Promise<BankAccount>
	func withdraw(query: TransferQuery) -> Promise<EmptyResponse>
	func replenish(query: TransferQuery) -> Promise<EmptyResponse>
	func makeTransfer(query: MakeBankAccountTransferQuery) -> Promise<BankAccount>
	func create() -> Promise<BankAccount>
	func close(accountId: Int64) -> Promise<EmptyResponse>
	func getOperaionHistory(accountId: Int64) -> Promise<[Operation]>
}

protocol LoansNetworkProtocol {
	func getLoans() -> Promise<[Loan]>
	func repay(query: RepayLoanQuery) -> Promise<RepaymentModel>
	func create(query: CreateLoanQuery) -> Promise<Loan>
}
