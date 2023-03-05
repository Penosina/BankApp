//
//  AuthCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation

protocol AuthCoordinatorDelegate: AnyObject {
	func authCoordinatorDidFinish()
}

final class AuthCoordinator: Coordinator {
	weak var delegate: AuthCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showAuth(animated: animated)
	}

	private func showAuth(animated: Bool) {
		let viewModel = AuthViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = AuthViewController(viewModel: viewModel)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension AuthCoordinator: AuthViewModelDelegate {
	func authViewModelDidFinish() {
		delegate?.authCoordinatorDidFinish()
		onDidFinish?()
	}
}
