//
//  LoanCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import Foundation

struct LoanCoordinatorConfiguration {
	let loan: Loan
}

protocol LoanViewModelInput: AnyObject {
	func update(loan: Loan)
}

final class LoanCoordinator: ConfigurableCoordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private weak var viewModel: LoanViewModelInput?

	private let configuration: LoanCoordinatorConfiguration

	init(navigationController: NavigationController,
		 appDependency: AppDependency,
		 configuration: LoanCoordinatorConfiguration) {
		self.navigationController = navigationController
		self.appDependency = appDependency
		self.configuration = configuration
	}

	func start(animated: Bool) {
		showLoan(animated: animated)
	}

	private func showLoan(animated: Bool) {
		let viewModel = LoanViewModel(dependencies: appDependency,
									  loan: configuration.loan)
		viewModel.delegate = self
		let vc = LoanViewController(viewModel: viewModel)
		self.viewModel = viewModel
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension LoanCoordinator: LoanViewModelDelegate {
	func loanViewModel(didRequestToRepayLoan loan: Loan) {
		let configuration = LoanCalculatorCoordinatorConfiguration(loan: loan)
		let coordinator = show(LoanCalculatorCoordinator.self, configuration, animated: true)
		coordinator.delegate = self
	}
}

extension LoanCoordinator: LoanCalculatorCoordinatorDelegate {
	func loanCalculatorCoordinator(didRequestToUpdateLoan loan: Loan) {
		viewModel?.update(loan: loan)
	}
}
