//
//  BankAccountCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 02.03.2023.
//

import Foundation

protocol BankAccountCoordinatorDelegate: AnyObject {
	func bankAccountCoordinator(didRequestToCloseAccount bankAccount: BankAccount)
	func bankAccountCoordinator(didRequestUpdateAccount bankAccount: BankAccount)
}

protocol BankAccountViewModelInput: AnyObject {
	func updateBankAccount(with bankAccount: BankAccount,
						   and operation: Operation)
}

struct BankAccountCoordinatorConfiguration {
	let bankAccount: BankAccount
}

final class BankAccountCoordinator: ConfigurableCoordinator {
	weak var delegate: BankAccountCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private let configuration: BankAccountCoordinatorConfiguration
	private weak var viewModel: BankAccountViewModelInput?

	init(navigationController: NavigationController, appDependency: AppDependency, configuration: BankAccountCoordinatorConfiguration) {
		self.navigationController = navigationController
		self.appDependency = appDependency
		self.configuration = configuration
	}

	func start(animated: Bool) {
		showBankAccount(animated: animated)
	}

	private func showBankAccount(animated: Bool) {
		let viewModel = BankAccountViewModel(dependencies: appDependency,
											 bankAccount: configuration.bankAccount)
		viewModel.delegate = self
		let vc = BankAccountViewController(viewModel: viewModel)
		self.viewModel = viewModel
		addPopObserver(for: vc)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension BankAccountCoordinator: BankAccountViewModelDelegate {
	func bankAccountViewModel(didRequest action: ActionType, with bankAccount: BankAccount) {
		switch action {
		case .makeTransfer:
			let configuration = MakeTransferCoordinatorConfiguration(bankAccount: bankAccount)
			let coordinator = show(MakeTransferCoordinator.self, configuration, animated: true)
			coordinator.delegate = self
		case .replenish, .withdraw:
			let configuration = CalculatorCoordinatorConfiguration(bankAccount: bankAccount,
																   action: action)
			let coordinator = show(CalculatorCoordinator.self, configuration, animated: true)
			coordinator.delegate = self
		}
	}

	func bankAccountViewModel(didRequestCloseAccount bankAccount: BankAccount) {
		delegate?.bankAccountCoordinator(didRequestToCloseAccount: bankAccount)
	}

	func bankAccountViewModel(didRequestUpdateAccount bankAccount: BankAccount) {
		delegate?.bankAccountCoordinator(didRequestUpdateAccount: bankAccount)
	}
}

extension BankAccountCoordinator: CalculatorCoordinatorDelegate {
	func calculatorCoordinator(didUpdateBankAccount bankAccount: BankAccount,
							   andCreateNewOperation operation: Operation) {
		viewModel?.updateBankAccount(with: bankAccount, and: operation)
	}
}

extension BankAccountCoordinator: MakeTransferCoordinatorDelegate {
	func makeTransferCoordinator(didUpdateBankAccount bankAccount: BankAccount,
								 andCreateNewOperation operation: Operation) {
		viewModel?.updateBankAccount(with: bankAccount, and: operation)
	}
}
