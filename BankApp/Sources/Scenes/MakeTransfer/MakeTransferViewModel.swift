//
//  MakeTransferViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 12.04.2023.
//

import Foundation
import PromiseKit

protocol MakeTransferViewModelDelegate: AnyObject {
	func makeTransferViewModel(didUpdateBankAccount bankAccount: BankAccount,
							   andCreateNewOperation operation: Operation)
	func makeTransferViewModelDidRequestToOpenBankAccountList(handler: @escaping (BankAccount) -> Void)
}

final class MakeTransferViewModel {
	typealias Dependencies = HasBankAccountsService

	weak var delegate: MakeTransferViewModelDelegate?

	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidReceiveError: ((Error) -> Void)?
	var onDidUpdateWithdrawalAccount: (() -> Void)?
	var onDidUpdateReplenishAccount: (() -> Void)?

	var withdrawalAccountNumber: String {
		return "№\(bankAccount.accountNumber)"
	}

	var withdrawalAccountBalance: String {
		return "\(bankAccount.balance) ₽"
	}

	var replenishAccountButtonTitle: String {
		guard let replenishAccount else { return "Упс.. Ошибка!" }
		return "Счет зачисления: \(replenishAccount.accountNumber)"
	}

	private var replenishAccount: BankAccount?

	private let dependencies: Dependencies
	private let bankAccount: BankAccount

	init(dependencies: Dependencies, bankAccount: BankAccount) {
		self.dependencies = dependencies
		self.bankAccount = bankAccount
	}

	func selectReplenishAccount() {
		delegate?.makeTransferViewModelDidRequestToOpenBankAccountList { [weak self] bankAccount in
			self?.replenishAccount = bankAccount
			self?.onDidUpdateReplenishAccount?()
		}
	}

	func makeTransfer(amountString: String?) {
		guard
			let replenishAccount = replenishAccount
		else { return }

		guard
			let amountString = amountString,
			let amount = Double(amountString)
		else { return }

		let operaion = Operation(value: "\(amount)",
								 executeDate: "Сейчас",
								 type: .transfer,
								 accountReplenishmentId: replenishAccount.id,
								 accountDebitingId: bankAccount.id)
		let query = MakeBankAccountTransferQuery(amount: amount,
												 accountDebitingId: bankAccount.id,
												 accountReplenishmentId: replenishAccount.id)
		process(dependencies.bankAccountsService.makeTransfer(query: query),
				operation: operaion)
	}

	private func process(_ promise: Promise<BankAccount>, operation: Operation) {
		onDidStartRequest?()
		promise.ensure {
			self.onDidFinishRequest?()
		}.done { bankAccount in
			self.handle(bankAccount: bankAccount, operation: operation)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(bankAccount: BankAccount, operation: Operation) {
		delegate?.makeTransferViewModel(didUpdateBankAccount: bankAccount,
										andCreateNewOperation: operation)
	}
}
