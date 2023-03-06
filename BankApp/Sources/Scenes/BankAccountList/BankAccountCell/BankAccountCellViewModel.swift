//
//  BankAccountCellViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

protocol BankAccountCellViewModelDelegate: AnyObject {
	func bankAccountCellViewModel(didRequestToShowBankAccount bankAccount: BankAccount)
}

final class BankAccountCellViewModel {
	weak var delegate: BankAccountCellViewModelDelegate?

	var balance: String {
		"\(bankAccount.balance) ₽"
	}

	var accountName: String {
		bankAccount.accountNumber
	}

	private let bankAccount: BankAccount

	init(bankAccount: BankAccount) {
		self.bankAccount = bankAccount
	}

	func didTap() {
		delegate?.bankAccountCellViewModel(didRequestToShowBankAccount: bankAccount)
	}
}
