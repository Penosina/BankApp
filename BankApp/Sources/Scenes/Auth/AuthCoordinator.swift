//
//  AuthCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation
import SafariServices

protocol AuthCoordinatorDelegate: AnyObject {
	func authCoordinatorDidFinish(hasReceivedDeepLink: Bool)
}

final class AuthCoordinator: NSObject, Coordinator {
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
		guard let authPageURL = URL(string: "http://localhost:8765/client/auth-page") else { return }

		let viewModel = AuthViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = AuthViewController(viewModel: viewModel, authPageURL: authPageURL)
		vc.delegate = self
		vc.modalPresentationStyle = .formSheet
		navigationController.present(vc, animated: animated)
	}
}

extension AuthCoordinator: AuthViewModelDelegate {
	func authViewModelDidReceiveDeepLink() {
		delegate?.authCoordinatorDidFinish(hasReceivedDeepLink: true)
		onDidFinish?()
	}
}

extension AuthCoordinator: SFSafariViewControllerDelegate {
	func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
		delegate?.authCoordinatorDidFinish(hasReceivedDeepLink: false)
		onDidFinish?()
	}
}
