//
//  LoanViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import Foundation

protocol LoanViewModelDelegate: AnyObject {
	func loanViewModel(didRequestToRepayLoan loan: Loan)
	func loanViewModelDidRequestToCloseScreen()
}

final class LoanViewModel {
	typealias Dependencies = HasLoansService

	weak var delegate: LoanViewModelDelegate?

	var onDidUpdateData: (() -> Void)?

	var title: String {
		loan.rate.name
	}

	var amount: String {
		"\(loan.amount) ₽"
	}

	var debt: String {
		"\(loan.debt) ₽"
	}

	var rate: String {
		"\(loan.rate.rate)%"
	}

	var period: String {
		"\(loan.period) месяцев"
	}

	private var loan: Loan
	private let dependencies: Dependencies

	init(dependencies: Dependencies, loan: Loan) {
		self.dependencies = dependencies
		self.loan = loan
	}

	func repay() {
		delegate?.loanViewModel(didRequestToRepayLoan: loan)
	}
}

extension LoanViewModel: LoanViewModelInput {
	func update(loan: Loan) {
		self.loan = loan
		onDidUpdateData?()
	}
	
	func didEnd() {
		delegate?.loanViewModelDidRequestToCloseScreen()
	}
}
