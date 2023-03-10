//
//  OperationHistoryViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import PromiseKit
import Foundation

final class OperationHistoryViewModel {
	typealias Dependencies = HasBankAccountsService

	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidLoadData: (() -> Void)?
	var onDidReceiveError: ((Error) -> Void)?

	private(set) var operationViewModels: [OperationViewModel] = []

	private var operations: [Operation] = []

	private let dependencies: Dependencies
	private let bankAccount: BankAccount

	init(dependencies: Dependencies, bankAccount: BankAccount) {
		self.dependencies = dependencies
		self.bankAccount = bankAccount
	}

	func start() {
		loadOperationHistory()
	}

	func add(operation: Operation) {
		let operations = self.operations + [operation]
		handle(operations: operations)
	}

	private func loadOperationHistory() {
//		let operations = [
//			Operation(value: "123", executeDate: "Сегодня", type: .in),
//			Operation(value: "234", executeDate: "Сегодня", type: .out),
//			Operation(value: "456", executeDate: "Сегодня", type: .in),
//			Operation(value: "567", executeDate: "Сегодня", type: .out),
//			Operation(value: "678", executeDate: "Сегодня", type: .in),
//		]
//		handle(operations: operations)

		onDidStartRequest?()
		firstly {
			dependencies.bankAccountsService.getOperaionHistory(accountId: bankAccount.id)
		}.ensure {
			self.onDidFinishRequest?()
		}.done { operations in
			self.handle(operations: operations)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(operations: [Operation]) {
		self.operations = operations
		convertToViewModels(operations: operations)
		onDidLoadData?()
	}

	private func convertToViewModels(operations: [Operation]) {
		operationViewModels = operations.map { OperationViewModel(operation: $0) }
	}
}
