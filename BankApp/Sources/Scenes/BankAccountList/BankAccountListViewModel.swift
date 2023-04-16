//
//  BankAccountListViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 02.03.2023.
//

import PromiseKit
import Foundation

protocol BankAccountListViewModelDelegate: AnyObject {
	func bankAccountListViewModel(didRequestToShowBankAccount bankAccount: BankAccount)
}

final class BankAccountListViewModel {
	typealias Dependencies = HasBankAccountsService

	weak var delegate: BankAccountListViewModelDelegate?

	var onDidReceiveError: ((Error) -> Void)?
	var onDidStartRequest: (() -> Void)?
	var onDidFinishRequest: (() -> Void)?
	var onDidLoadData: (() -> Void)?

	private(set) var bankAccountViewModels: [BankAccountCellViewModel] = []

	private var bankAccounts: [BankAccount] = []

	private let dependencies: Dependencies
	private let getAccountsBehaviour: GetAccountsBehaviourType

	init(dependencies: Dependencies, getAccountsBehaviour: GetAccountsBehaviourType) {
		self.dependencies = dependencies
		self.getAccountsBehaviour = getAccountsBehaviour
	}

	func start() {
		getBankAccounts()
	}

	func didTapCreateNewBankAccountButton() {
		createNewBankAccount()
	}

	private func getBankAccounts() {
//		let bankAccounts = [
//			BankAccount(id: 1, accountNumber: "1", balance: 1234.24),
//			BankAccount(id: 2, accountNumber: "223", balance: 0.12),
//			BankAccount(id: 3, accountNumber: "234543", balance: 2121232324.24),
//			BankAccount(id: 4, accountNumber: "2123", balance: 1234.24),
//			BankAccount(id: 5, accountNumber: "Мой кеш", balance: 1234.24),
//			BankAccount(id: 6, accountNumber: "фывф", balance: 1234.24),
//			BankAccount(id: 7, accountNumber: "88855", balance: 1234.24),
//		]
//		handle(bankAccounts)

		onDidStartRequest?()
		firstly {
			switch getAccountsBehaviour {
			case .getAll:
				return dependencies.bankAccountsService.getAccountsToTransfer()
			case .getOwn:
				return dependencies.bankAccountsService.getAccounts()
			}
		}.ensure {
			self.onDidFinishRequest?()
		}.done { bankAccounts in
			self.handle(bankAccounts)
			self.onDidLoadData?()
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func handle(_ bankAccounts: [BankAccount]) {
		self.bankAccounts = bankAccounts
		convertToViewModels(bankAccounts: bankAccounts)
		onDidLoadData?()
	}

	private func convertToViewModels(bankAccounts: [BankAccount]) {
		bankAccountViewModels = bankAccounts.map {
			let bankAccountCellViewModel = BankAccountCellViewModel(bankAccount: $0)
			bankAccountCellViewModel.delegate = self
			return bankAccountCellViewModel
		}
	}

	private func createNewBankAccount() {
		onDidStartRequest?()
		firstly {
			dependencies.bankAccountsService.create()
		}.ensure {
			self.onDidFinishRequest?()
		}.done { bankAccount in
			self.add(bankAccount: bankAccount)
		}.catch { error in
			self.onDidReceiveError?(error)
		}
	}

	private func add(bankAccount: BankAccount) {
		let bankAccounts = bankAccounts + [bankAccount]
		handle(bankAccounts)
	}
}

extension BankAccountListViewModel: BankAccountCellViewModelDelegate {
	func bankAccountCellViewModel(didRequestToShowBankAccount bankAccount: BankAccount) {
		delegate?.bankAccountListViewModel(didRequestToShowBankAccount: bankAccount)
	}
}

extension BankAccountListViewModel: BankAccountListViewModelInput {
	func remove(bankAccount: BankAccount) {
		if let index = bankAccounts.firstIndex(where: { $0.id == bankAccount.id }) {
			bankAccounts.remove(at: index)
			handle(bankAccounts)
		}
	}

	func update(bankAccount: BankAccount) {
		if let index = bankAccounts.firstIndex(where: { $0.id == bankAccount.id }) {
			bankAccounts[index] = bankAccount
			handle(bankAccounts)
		}
	}
}
