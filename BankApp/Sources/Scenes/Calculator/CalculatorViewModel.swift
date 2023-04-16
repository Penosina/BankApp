//
//  CalculatorViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import Foundation
import PromiseKit

protocol CalculatorViewModelDelegate: AnyObject {
	func calculatorViewModel(didUpdateBankAccount bankAccount: BankAccount,
							 andCreateNewOperation operation: Operation)
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
		case .makeTransfer:
			return "Ошибка"
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

		let query = TransferQuery(accountId: bankAccount.id, amount: amount)
		let operaion: Operation?
		let promise: Promise<EmptyResponse>?
		switch action {
		case .withdraw:
			bankAccount = BankAccount(id: bankAccount.id,
									  accountNumber: bankAccount.accountNumber,
									  balance: bankAccount.balance - amount)
			operaion = Operation(value: "\(amount)",
								 executeDate: "Now",
								 type: .in,
								 accountReplenishmentId: bankAccount.id,
								 accountDebitingId: nil)
			promise = dependencies.bankAccountsService.withdraw(query: query)
		case .replenish:
			bankAccount = BankAccount(id: bankAccount.id,
									  accountNumber: bankAccount.accountNumber,
									  balance: bankAccount.balance + amount)
			operaion = Operation(value: "\(amount)",
								 executeDate: "Сейчас",
								 type: .out,
								 accountReplenishmentId: nil,
								 accountDebitingId: bankAccount.id)
			promise = dependencies.bankAccountsService.replenish(query: query)
		case .makeTransfer:
			promise = nil
			operaion = nil
		}
		process(promise, with: bankAccount, and: operaion)

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

	private func process(_ promise: Promise<EmptyResponse>?, with bankAccount: BankAccount, and operation: Operation?) {
		guard let promise, let operation else { fatalError("Случилось что-то плохое((") }

		onDidStartRequest?()

		firstly {
			promise
		}.ensure {
			self.onDidFinishRequest?()
		}.done { _ in
			self.handle(bankAccount: bankAccount, operation: operation)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(bankAccount: BankAccount, operation: Operation) {
		self.bankAccount = bankAccount
		onDidLoadData?()
		delegate?.calculatorViewModel(didUpdateBankAccount: bankAccount,
									  andCreateNewOperation: operation)
	}
}
