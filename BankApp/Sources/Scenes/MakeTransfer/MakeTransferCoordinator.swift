//
//  MakeTransferCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 12.04.2023.
//

import Foundation

protocol MakeTransferCoordinatorDelegate: AnyObject {
	func makeTransferCoordinator(didUpdateBankAccount bankAccount: BankAccount,
								 andCreateNewOperation operation: Operation)
}

struct MakeTransferCoordinatorConfiguration {
	let bankAccount: BankAccount
}

final class MakeTransferCoordinator: ConfigurableCoordinator {
	weak var delegate: MakeTransferCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private var didSelectBankAccountHandler: ((BankAccount) -> Void)?
	private let configuration: MakeTransferCoordinatorConfiguration

	init(navigationController: NavigationController, appDependency: AppDependency, configuration: MakeTransferCoordinatorConfiguration) {
		self.navigationController = navigationController
		self.appDependency = appDependency
		self.configuration = configuration
	}

	func start(animated: Bool) {
		showMakeTransfer(animated: animated)
	}

	private func showMakeTransfer(animated: Bool) {
		let viewModel = MakeTransferViewModel(dependencies: appDependency,
											  bankAccount: configuration.bankAccount)
		viewModel.delegate = self
		let vc = MakeTransferViewController(viewModel: viewModel)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension MakeTransferCoordinator: MakeTransferViewModelDelegate {
	func makeTransferViewModel(didUpdateBankAccount bankAccount: BankAccount,
							   andCreateNewOperation operation: Operation) {
		delegate?.makeTransferCoordinator(didUpdateBankAccount: bankAccount,
										  andCreateNewOperation: operation)
	}

	func makeTransferViewModelDidRequestToOpenBankAccountList(handler: @escaping (BankAccount) -> Void) {
		didSelectBankAccountHandler = handler
		let configuration = SelectBankAccountCoordinatorConfiguration(getAccountsBehaviour: .getAll)
		let coordinator = show(SelectBankAccountCoordinator.self, configuration, animated: true)
		coordinator.delegate = self
	}
}

extension MakeTransferCoordinator: SelectBankAccountCoordinatorDelegate {
	func selectBankAccountCoordinator(didSelectBankAccount bankAccount: BankAccount) {
		didSelectBankAccountHandler?(bankAccount)
		didSelectBankAccountHandler = nil
	}
}
