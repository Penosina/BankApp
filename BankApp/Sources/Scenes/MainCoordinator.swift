//
//  MainCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit

final class MainCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency = AppDependency()) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		setupOAuthAuthenticator()

		if appDependency.dataStore.tokens != nil {
			showTabBar(animated: animated)
		} else {
			showWelcomeScreen(animated: animated)
		}
	}

	private func showTabBar(animated: Bool) {
		show(TabBarCoordinator.self, animated: animated)
	}

	private func showWelcomeScreen(animated: Bool) {
		let coordinator = show(WelcomeCoordinator.self, animated: animated)
		coordinator.delegate = self
	}

	private func resetCoordinators() {
		navigationController.dismiss(animated: false, completion: nil)
		navigationController.setViewControllers([], animated: false)
		navigationController.removeAllPopObservers()
		childCoordinators.removeAll()
		start(animated: false)
	}

	private func setupOAuthAuthenticator() {
		appDependency.authenticator.delegate = appDependency.oAuthService
		appDependency.oAuthService.updateSessionCredentials()
	}
}

extension MainCoordinator: WelcomeCoordinatorDelegate {
	func welcomeCoordinatorDidFinish() {
		resetCoordinators()
	}
}
