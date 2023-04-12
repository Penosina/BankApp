//
//  TakeLoanCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import Foundation

protocol TakeLoanCoordinatorDelegate: AnyObject {
	func takeLoanCoordinator(didRequestToAddLoan loan: Loan)
}

final class TakeLoanCoordinator: Coordinator {
	weak var delegate: TakeLoanCoordinatorDelegate?

	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	private var didSelectBankAccountHandler: ((BankAccount) -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showTakeLoan(animated: animated)
	}

	private func showTakeLoan(animated: Bool) {
		let viewModel = TakeLoanViewModel(dependencies: appDependency)
		viewModel.delegate = self
		let vc = TakeLoanViewController(viewModel: viewModel)
		navigationController.pushViewController(vc, animated: animated)
	}
}

extension TakeLoanCoordinator: TakeLoanViewModelDelegate {
	func takeLoanViewModel(didRequestToAddLoan loan: Loan) {
		delegate?.takeLoanCoordinator(didRequestToAddLoan: loan)
		navigationController.popViewController(animated: true)
	}

	func takeLoanViewModelDidRequestToOpenBankAccountList(handler: @escaping (BankAccount) -> Void) {
		didSelectBankAccountHandler = handler
		let configuration = SelectBankAccountCoordinatorConfiguration(getAccountsBehaviour: .getAll)
		let coordinator = show(SelectBankAccountCoordinator.self, configuration, animated: true)
		coordinator.delegate = self
	}
}

extension TakeLoanCoordinator: SelectBankAccountCoordinatorDelegate {
	func selectBankAccountCoordinator(didSelectBankAccount bankAccount: BankAccount) {
		didSelectBankAccountHandler?(bankAccount)
		didSelectBankAccountHandler = nil
	}
}
