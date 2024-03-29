//
//  BankAccountViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 02.03.2023.
//

import Foundation
import PromiseKit

protocol BankAccountViewModelDelegate: AnyObject {
	func bankAccountViewModel(didRequest action: ActionType, with bankAccount: BankAccount)
	func bankAccountViewModel(didRequestCloseAccount bankAccount: BankAccount)
	func bankAccountViewModel(didRequestUpdateAccount bankAccount: BankAccount)
}

final class BankAccountViewModel {
	typealias Dependencies = HasBankAccountsService & HasWebSocketService

	weak var delegate: BankAccountViewModelDelegate?

	var onDidReceiveError: ((Error) -> Void)?
	var onDidLoadData: (() -> Void)?
	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?

	lazy var screenTitle: String = {
		"Счёт \(bankAccount.id)"
	}()
	var balance: String {
		"\(bankAccount.balance) ₽"
	}

	let operationHistoryViewModel: OperationHistoryViewModel

	private var bankAccount: BankAccount

	private let dependencies: Dependencies

	init(dependencies: Dependencies, bankAccount: BankAccount) {
		self.dependencies = dependencies
		self.bankAccount = bankAccount
		self.operationHistoryViewModel = OperationHistoryViewModel(dependencies: dependencies,
																   bankAccount: bankAccount)
	}

	func start() {
		getProfile()
	}

	func didRequestWithdraw() {
		delegate?.bankAccountViewModel(didRequest: .withdraw, with: bankAccount)
	}

	func didRequestReplenish() {
		delegate?.bankAccountViewModel(didRequest: .replenish, with: bankAccount)
	}

	func didRequestMakeTransfer() {
		delegate?.bankAccountViewModel(didRequest: .makeTransfer, with: bankAccount)
	}

	func didRequestCloseAccount() {
		closeAccount()
	}

	private func getProfile() {
//		onDidStartRequest?()
//		firstly {
//			dependencies.bankAccountsService.getAccount(with: bankAccount.id)
//		}.ensure {
//			self.onDidFinishRequest?()
//		}.done { bankAccount in
//			self.handle(bankAccount: bankAccount)
//		}.catch { error in
//			self.onDidReceiveError?(error)
//		}
	}

	private func handle(bankAccount: BankAccount) {
		self.bankAccount = bankAccount
		onDidLoadData?()
	}

	private func closeAccount() {
		onDidStartRequest?()
		self.dependencies.bankAccountsService.close(accountId: bankAccount.id).ensure {
			self.onDidFinishRequest?()
		}.done { _ in
			self.delegate?.bankAccountViewModel(didRequestCloseAccount: self.bankAccount)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}
}

extension BankAccountViewModel: BankAccountViewModelInput {
	func updateBankAccount(with bankAccount: BankAccount, and operation: Operation) {
		handle(bankAccount: bankAccount)
		operationHistoryViewModel.add(operation: operation)
		delegate?.bankAccountViewModel(didRequestUpdateAccount: bankAccount)
	}
}
