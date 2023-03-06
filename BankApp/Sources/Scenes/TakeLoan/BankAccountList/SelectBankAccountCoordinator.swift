//
//  SelectBankAccountCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import Foundation

struct SelectBankAccountCoordinatorConfiguration {
	let didSelectBankAccountHandler: (BankAccount) -> Void
}

final class SelectBankAccountCoordinator: ConfigurableCoordinator {

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private let configuration: SelectBankAccountCoordinatorConfiguration

	init(navigationController: NavigationController,
		 appDependency: AppDependency,
		 configuration: SelectBankAccountCoordinatorConfiguration) {
		self.navigationController = navigationController
		self.appDependency = appDependency
		self.configuration = configuration
	}

	func start(animated: Bool) {
		showBankAccountList(animated: animated)
	}

	private func showBankAccountList(animated: Bool) {
		let viewModel = BankAccountListViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = BankAccountListViewController(viewModel: viewModel)
		vc.setCreateNewBankAccountButtonHidden(true)
		addPopObserver(for: vc)
		navigationController.present(vc, animated: animated)
	}
}

extension SelectBankAccountCoordinator: BankAccountListViewModelDelegate {
	func bankAccountListViewModel(didRequestToShowBankAccount bankAccount: BankAccount) {
		configuration.didSelectBankAccountHandler(bankAccount)
		navigationController.dismiss(animated: true)
	}
}
