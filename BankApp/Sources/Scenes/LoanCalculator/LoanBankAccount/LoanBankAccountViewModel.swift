//
//  LoanBankAccountViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import Foundation

final class LoanBankAccountViewModel {
	typealias Dependencies = HasBankAccountsService

	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidLoadData: (() -> Void)?
	var onDidReceiveError: ((Error) -> Void)?

	var balance: String {
		guard let bankAccount = bankAccount else {
			return "Упс.. Ошибка!"
		}
		return "\(bankAccount.balance) ₽"
	}

	private var bankAccount: BankAccount?

	private let dependencies: Dependencies
	private let accountId: Int64

	init(dependencies: Dependencies, accountId: Int64) {
		self.dependencies = dependencies
		self.accountId = accountId
	}

	func start() {
		getBankAccount()
	}

	private func getBankAccount() {
		onDidStartRequest?()
		dependencies.bankAccountsService.getAccount(accountId: accountId).ensure {
			self.onDidFinishRequest?()
		}.done { bankAccount in
			self.handle(bankAccocunt: bankAccount)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(bankAccocunt: BankAccount) {
		self.bankAccount = bankAccocunt
		onDidLoadData?()
	}
}
