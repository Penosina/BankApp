//
//  LoanListViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import PromiseKit

protocol LoanListViewModelDelegate: AnyObject {
	func loanListViewModelDidRequestToGetLoan()
	func loanListViewModel(didRequestToShowLoan loan: Loan)
}

final class LoanListViewModel {
	typealias Dependencies = HasLoansService

	weak var delegate: LoanListViewModelDelegate?

	var onDidReceiveError: ((Error) -> Void)?
	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidLoadData: (() -> Void)?

	private(set) var loanViewModels: [LoanCellViewModel] = []

	private var loans: [Loan] = []

	private let dependencies: Dependencies

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}

	func start() {
		getLoans()
	}

	func didRequestToTakeLoan() {
		delegate?.loanListViewModelDidRequestToGetLoan()
	}

	private func getLoans() {
		let loanRate = LoanRate(id: 12, name: "Кредит Х", rate: 8)
		let loans = [
			Loan(id: 10, debt: 76, amount: 12345, period: 6, rate: loanRate, accountDebitingId: 1),
			Loan(id: 11, debt: 190, amount: 12345, period: 12, rate: loanRate, accountDebitingId: 2),
			Loan(id: 12, debt: 334, amount: 12345, period: 24, rate: loanRate, accountDebitingId: 3),
			Loan(id: 13, debt: 7777, amount: 12345, period: 10, rate: loanRate, accountDebitingId: 4)
		]
		handle(loans: loans)
//		onDidStartRequest?()
//		dependencies.loansService.getLoans().ensure {
//			self.onDidFinishRequest?()
//		}.done { loans in
//			self.handle(loans: loans)
//		}.catch { error in
//			self.onDidReceiveError?(error)
//		}
	}

	private func handle(loans: [Loan]) {
		self.loans = loans
		convertToViewModels()
		onDidLoadData?()
	}

	private func convertToViewModels() {
		loanViewModels = loans.map { loan in
			let viewModel = LoanCellViewModel(loan: loan)
			viewModel.delegate = self
			return viewModel
		}
	}
}

extension LoanListViewModel: LoanCellViewModelDelegate {
	func loanCellViewModel(didRequestToShowLoan loan: Loan) {
		delegate?.loanListViewModel(didRequestToShowLoan: loan)
	}
}

extension LoanListViewModel: LoanListViewModelInput {
	func add(loan: Loan) {
		let loans = [loan] + loans
		handle(loans: loans)
	}
}
