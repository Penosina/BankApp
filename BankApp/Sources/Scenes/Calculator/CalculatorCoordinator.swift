//
//  CalculatorCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import Foundation

protocol CalculatorCoordinatorDelegate: AnyObject {
	func calculatorCoordinator(didUpdateBankAccount bankAccount: BankAccount,
							   andCreateNewOperation operation: Operation)
}

struct CalculatorCoordinatorConfiguration {
	let bankAccount: BankAccount
	let action: ActionType
}

final class CalculatorCoordinator: ConfigurableCoordinator {
	weak var delegate: CalculatorCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private let configuration: CalculatorCoordinatorConfiguration

	init(navigationController: NavigationController,
		 appDependency: AppDependency,
		 configuration: CalculatorCoordinatorConfiguration) {
		self.navigationController = navigationController
		self.appDependency = appDependency
		self.configuration = configuration
	}

	func start(animated: Bool) {
		showCalculator(animated: animated)
	}

	private func showCalculator(animated: Bool) {
		let viewModel = CalculatorViewModel(bankAccount: configuration.bankAccount,
											action: configuration.action,
											dependencies: appDependency)
		viewModel.delegate = self
		let vc = CalculatorViewController(viewModel: viewModel)
		addPopObserver(for: vc)
		navigationController.present(vc, animated: animated)
	}
}

extension CalculatorCoordinator: CalculatorViewModelDelegate {
	func calculatorViewModel(didUpdateBankAccount bankAccount: BankAccount,
							 andCreateNewOperation operation: Operation) {
		delegate?.calculatorCoordinator(didUpdateBankAccount: bankAccount,
										andCreateNewOperation: operation)
		navigationController.dismiss(animated: true)
	}
}
