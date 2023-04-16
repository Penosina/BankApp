//
//  OverduePaymentCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 17.04.2023.
//

import Foundation

final class OverduePaymentCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController,
		 appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showOverduePayments(animated: animated)
	}

	private func showOverduePayments(animated: Bool) {
		let viewModel = OverduePaymentViewModel(dependencies: appDependency)
		let vc = OverduePaymentViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}
