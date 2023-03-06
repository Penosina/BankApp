//
//  LoanListCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import Foundation

protocol LoanListViewModelInput: AnyObject {
	func add(loan: Loan)
}

final class LoanListCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private weak var viewModel: LoanListViewModelInput?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showLoanList(animated: animated)
	}

	private func showLoanList(animated: Bool) {
		let viewModel = LoanListViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = LoanListViewController(viewModel: viewModel)
		self.viewModel = viewModel
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension LoanListCoordinator: LoanListViewModelDelegate {
	func loanListViewModelDidRequestToGetLoan() {
		let coordinator = show(TakeLoanCoordinator.self, animated: true)
		coordinator.delegate = self
	}

	func loanListViewModel(didRequestToShowLoan loan: Loan) {
		let configuration = LoanCoordinatorConfiguration(loan: loan)
		show(LoanCoordinator.self, configuration, animated: true)
	}
}

extension LoanListCoordinator: TakeLoanCoordinatorDelegate {
	func takeLoanCoordinator(didRequestToAddLoan loan: Loan) {
		viewModel?.add(loan: loan)
	}
}
