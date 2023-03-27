//
//  WelcomeCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation

protocol WelcomeCoordinatorDelegate: AnyObject {
	func welcomeCoordinatorDidFinish()
}

final class WelcomeCoordinator: Coordinator {
	weak var delegate: WelcomeCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showWelcome(animated: animated)
	}

	private func showWelcome(animated: Bool) {
		let viewModel = WelcomeViewModel()
		viewModel.delegate = self
		let vc = WelcomeViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension WelcomeCoordinator: WelcomeViewModelDelegate {
	func welcomeViewModelDidRequestToShowAuth() {
		let coordinator = show(AuthCoordinator.self, animated: true)
		coordinator.delegate = self
	}
}

extension WelcomeCoordinator: AuthCoordinatorDelegate {
	func authCoordinatorDidFinish(hasReceivedDeepLink: Bool) {
		delegate?.welcomeCoordinatorDidFinish()
		onDidFinish?()
	}
}
