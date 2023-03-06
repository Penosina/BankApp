//
//  TakeLoanViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import PromiseKit

protocol TakeLoanViewModelDelegate: AnyObject {
	func takeLoanViewModel(didRequestToAddLoan loan: Loan)
	func takeLoanViewModelDidRequestToOpenBankAccountList(handler: @escaping (BankAccount) -> Void)
}

final class TakeLoanViewModel {
	typealias Dependencies = HasLoansService

	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidReceiveError: ((Error) -> Void)?
	var onDidUpdateWithdrawalAccount: (() -> Void)?
	var onDidUpdateReplenishAccount: (() -> Void)?

	var withdrawalAccountButtonTitle: String {
		guard let withdrawalAccount = withdrawalAccount else { return "Упс.. Ошибка!" }
		return "Счет списания: \(withdrawalAccount.accountNumber)"
	}

	var replenishAccountButtonTitle: String {
		guard let replenishAccount = replenishAccount else { return "Упс.. Ошибка!" }
		return "Счет зачисления: \(replenishAccount.accountNumber)"
	}


	weak var delegate: TakeLoanViewModelDelegate?

	private var replenishAccount: BankAccount?
	private var withdrawalAccount: BankAccount?

	private let dependencies: Dependencies

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}

	func selectReplenishAccount() {
		delegate?.takeLoanViewModelDidRequestToOpenBankAccountList() { [weak self] bankAccount in
			self?.replenishAccount = bankAccount
			self?.onDidUpdateReplenishAccount?()
		}
	}

	func selectWithdrawalAccount() {
		delegate?.takeLoanViewModelDidRequestToOpenBankAccountList() { [weak self] bankAccount in
			self?.withdrawalAccount = bankAccount
			self?.onDidUpdateWithdrawalAccount?()
		}
	}

	func takeLoan(amountString: String?, periodString: String?) {
		guard
			let replenishAccount = replenishAccount,
			let withdrawalAccount = withdrawalAccount
		else { return }

		guard
			let amountString = amountString,
			let periodString = periodString,
			let amount = Double(amountString),
			let period = Int(periodString)
		else { return }

		let loanRate = LoanRate(id: 12, name: "Кредитнулся", rate: 77)
		let loan = Loan(id: 1234,
						debt: amount,
						amount: amount,
						period: period,
						rate: loanRate,
						accountDebitingId: 123)
		delegate?.takeLoanViewModel(didRequestToAddLoan: loan)

//		let query = CreateLoanQuery(loanPeriod: period,
//									loanAmount: amount,
//									accountDebitingId: withdrawalAccount.id,
//									accountReplenishmentId: replenishAccount.id)
//		process(dependencies.loansService.create(query: query))
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
		delegate?.takeLoanViewModel(didRequestToAddLoan: loan)
	}
}
