//
//  LoanCellViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import Foundation

protocol LoanCellViewModelDelegate: AnyObject {
	func loanCellViewModel(didRequestToShowLoan loan: Loan)
}

final class LoanCellViewModel {
	weak var delegate: LoanCellViewModelDelegate?

	var rateName: String {
		"\(loan.rate.name)"
	}

	var additionalInfo: String {
		"Кредит на \(loan.period) мес. Ставка: \(loan.rate.rate)%"
	}

	var debt: String {
		"\(loan.debt) ₽"
	}

	private let loan: Loan

	init(loan: Loan) {
		self.loan = loan
	}

	func didTap() {
		delegate?.loanCellViewModel(didRequestToShowLoan: loan)
	}
}
