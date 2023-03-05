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
		"\(model.balance) ₽"
	}

	var accountName: String {
		model.accountNumber
	}

	private let model: BankAccount

	init(model: BankAccount) {
		self.model = model
	}

	func didTap() {
		delegate?.bankAccountCellViewModel(didRequestToShowBankAccount: model)
	}
}
