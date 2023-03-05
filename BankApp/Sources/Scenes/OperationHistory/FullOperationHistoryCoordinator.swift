//
//  FullOperationHistoryCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation

final class FullOperationHistoryCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		let viewModel = FullOperationHistoryViewModel()
		let vc = FullOperationHistoryViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}
