//
//  LoanCalculatorCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import Foundation

struct LoanCalculatorCoordinatorConfiguration {
	let loan: Loan
}

protocol LoanCalculatorCoordinatorDelegate: AnyObject {
	func loanCalculatorCoordinator(didRequestToUpdateLoan loan: Loan)
	func loanCalculatorCoordinatorDidRequestToCloseLoanScreen()
}

final class LoanCalculatorCoordinator: ConfigurableCoordinator {
	weak var delegate: LoanCalculatorCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private let configuration: LoanCalculatorCoordinatorConfiguration

	init(navigationController: NavigationController,
		 appDependency: AppDependency,
		 configuration: LoanCalculatorCoordinatorConfiguration) {
		self.navigationController = navigationController
		self.appDependency = appDependency
		self.configuration = configuration
	}

	func start(animated: Bool) {
		showLoanCalculator(animated: animated)
	}

	private func showLoanCalculator(animated: Bool) {
		let viewModel = LoanCalculatorViewModel(dependencies: appDependency,
												loan: configuration.loan)
		viewModel.delegate = self
		let vc = LoanCalculatorViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.present(vc, animated: animated)
	}
}

extension LoanCalculatorCoordinator: LoanCalculatorViewModelDelegate {
	func loanCalculatorViewModel(didRequestToUpdateLoan loan: Loan) {
		delegate?.loanCalculatorCoordinator(didRequestToUpdateLoan: loan)
		navigationController.dismiss(animated: true)
	}
	
	func loanCalculatorViewModelDidRequestToCloseLoanScreen() {
		delegate?.loanCalculatorCoordinatorDidRequestToCloseLoanScreen()
		navigationController.dismiss(animated: true)
	}
}
