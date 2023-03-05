//
//  FeedCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation

final class FeedCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []

	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		let viewModel = FeedViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = FeedViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension FeedCoordinator: FeedViewModelDelegate {
	func feedViewModelDidRequstToShowBankAccountList() {
		show(BankAccountListCoordinator.self, animated: true)
	}

	func feedViewModelDidRequstToShowLoanList() {
		show(LoanListCoordinator.self, animated: true)
	}
}
