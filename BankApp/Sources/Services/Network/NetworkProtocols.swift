//
//  NetworkProtocols.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import PromiseKit

protocol AuthNetworkProtocol {
	func refresh(refreshToken: String) -> Promise<AuthTokenPair>
	func updateSessionCredentials(with tokens: AuthTokenPair?)
}

protocol BankAccountsNetworkProtocol {
	func getAccounts() -> Promise<[BankAccount]>
	func getAccount(with accountId: String) -> Promise<BankAccount>
	func withdraw(query: TransferQuery) -> Promise<BankAccount>
	func replenish(query: TransferQuery) -> Promise<BankAccount>
	func create() -> Promise<BankAccount>
	func close(accountId: String) -> Promise<EmptyResponse>
	func getOperaionHistory(accountId: String) -> Promise<[Operation]>
}

protocol LoansNetworkProtocol {

}

protocol OperationHistoryNetworkProtocol {

}
