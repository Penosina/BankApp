//
//  LoanCalculatorViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import PromiseKit

protocol LoanCalculatorViewModelDelegate: AnyObject {
	func loanCalculatorViewModel(didRequestToUpdateLoan loan: Loan)
}

final class LoanCalculatorViewModel {
	typealias Dependencies = HasLoansService & HasBankAccountsService

	weak var delegate: LoanCalculatorViewModelDelegate?

	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidReceiveError: ((Error) -> Void)?

	let loanBankAccountViewModel: LoanBankAccountViewModel

	private let dependencies: Dependencies
	private let loan: Loan
	private var bankAccount: BankAccount?

	init(dependencies: Dependencies, loan: Loan) {
		self.dependencies = dependencies
		self.loan = loan
		self.loanBankAccountViewModel = LoanBankAccountViewModel(dependencies: dependencies,
																 accountId: loan.accountDebitingId)
	}

	func submit(amountString: String?) {
		guard
			let amountString = amountString,
			let amount = Double(amountString)
		else { return }

		let query = RepayLoanQuery(loanId: loan.id,
								   amount: amount,
								   accountId: loan.accountDebitingId)
		process(dependencies.loansService.repay(query: query))
	}

	private func process(_ promise: Promise<Loan>) {
		onDidStartRequest?()
		promise.ensure {
			self.onDidFinishRequest?()
		}.done { loan in
			self.handle(loan: loan)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(loan: Loan) {
		delegate?.loanCalculatorViewModel(didRequestToUpdateLoan: loan)
	}
}
