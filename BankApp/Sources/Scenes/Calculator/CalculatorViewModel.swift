//
//  CalculatorViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import Foundation
import PromiseKit

protocol CalculatorViewModelDelegate: AnyObject {
	func calculatorViewModel(didUpdateBankAccount bankAccount: BankAccount)
}

final class CalculatorViewModel {
	typealias Dependencies = HasBankAccountsService

	weak var delegate: CalculatorViewModelDelegate?

	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidLoadData: (() -> Void)?
	var onDidReceiveError: ((Error) -> Void)?

	var buttonTitle: String {
		switch action {
		case .replenish:
			return "Пополнить"
		case .withdraw:
			return "Снять"
		}
	}
	var balanceTitle: String {
		"\(bankAccount.balance) ₽"
	}

	private var bankAccount: BankAccount

	private let action: ActionType
	private let dependencies: Dependencies

	init(bankAccount: BankAccount, action: ActionType, dependencies: Dependencies) {
		self.bankAccount = bankAccount
		self.action = action
		self.dependencies = dependencies
	}

	func onDidButtonTapped(amountString: String?) {
		guard
			let amountString = amountString,
			let amount = Double(amountString) else { return }

		if case .withdraw = action, amount > bankAccount.balance {
			return
		}

		let query = TransferQuery(accountId: bankAccount.accountId, amount: amount)
		let promise: Promise<BankAccount>
		switch action {
		case .withdraw:
			promise = dependencies.bankAccountsService.withdraw(query: query)
		case .replenish:
			promise = dependencies.bankAccountsService.replenish(query: query)
		}
		process(promise)

//		let newBalance: Double
//		switch action {
//		case .withdraw:
//			newBalance = bankAccount.balance - query.amount
//		case .replenish:
//			newBalance = bankAccount.balance + query.amount
//		}
//
//		onDidStartRequest?()
//		handle(bankAccount: BankAccount(accountId: query.accountId, balance: newBalance))
//		onDidFinishRequest?()
	}

	private func process(_ promise: Promise<BankAccount>) {
		onDidStartRequest?()

		firstly {
			promise
		}.ensure {
			self.onDidFinishRequest?()
		}.done { bankAccount in
			self.handle(bankAccount: bankAccount)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(bankAccount: BankAccount) {
		self.bankAccount = bankAccount
		onDidLoadData?()
		delegate?.calculatorViewModel(didUpdateBankAccount: bankAccount)
	}
}
