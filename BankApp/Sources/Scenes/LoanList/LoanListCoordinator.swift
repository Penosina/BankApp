//
//  LoanListCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import Foundation

final class LoanListCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showLoanList(animated: animated)
	}

	private func showLoanList(animated: Bool) {
		let viewModel = LoanListViewModel()
		let vc = LoanListViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}
