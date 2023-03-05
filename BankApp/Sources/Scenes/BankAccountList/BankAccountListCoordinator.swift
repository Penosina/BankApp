//
//  BankAccountListCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 02.03.2023.
//

import Foundation

protocol BankAccountListViewModelInput: AnyObject {
	func remove(bankAccount: BankAccount)
}

final class BankAccountListCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private var viewModelInput: BankAccountListViewModel?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showBankAccountList(animated: animated)
	}

	private func showBankAccountList(animated: Bool) {
		let viewModel = BankAccountListViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = BankAccountListViewController(viewModel: viewModel)
		self.viewModelInput = viewModel
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension BankAccountListCoordinator: BankAccountListViewModelDelegate {
	func bankAccountListViewModel(didRequestToShowBankAccount bankAccount: BankAccount) {
		let configuration = BankAccountCoordinatorConfiguration(bankAccount: bankAccount)
		let coordinator = show(BankAccountCoordinator.self, configuration, animated: true)
		coordinator.delegate = self
	}
}

extension BankAccountListCoordinator: BankAccountCoordinatorDelegate {
	func bankAccountCoordinator(didRequestToCloseAccount bankAccount: BankAccount) {
		viewModelInput?.remove(bankAccount: bankAccount)
		navigationController.popViewController(animated: true)
	}
}
