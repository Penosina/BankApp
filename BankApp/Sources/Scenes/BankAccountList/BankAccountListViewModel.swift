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

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}

	func start() {
		getBankAccounts()
	}

	func didTapCreateNewBankAccountButton() {
		createNewBankAccount()
	}

	private func getBankAccounts() {
		let bankAccounts = [
			BankAccount(accountId: "1", balance: 1234.24),
			BankAccount(accountId: "223", balance: 0.12),
			BankAccount(accountId: "234543", balance: 2121232324.24),
			BankAccount(accountId: "2123", balance: 1234.24),
			BankAccount(accountId: "Мой кеш", balance: 1234.24),
			BankAccount(accountId: "фывф", balance: 1234.24),
			BankAccount(accountId: "88855", balance: 1234.24),
		]
		handle(bankAccounts)
//		onDidStartRequest?()
//		firstly {
//			dependencies.bankAccountsService.getAccounts()
//		}.ensure {
//			self.onDidFinishRequest?()
//		}.done { bankAccounts in
//			self.handle(bankAccounts)
//			self.onDidLoadData?()
//		}.catch { error in
//			self.onDidReceiveError?(error)
//		}
	}

	private func handle(_ bankAccounts: [BankAccount]) {
		self.bankAccounts = bankAccounts
		convertToViewModels(bankAccounts: bankAccounts)
		onDidLoadData?()
	}

	private func convertToViewModels(bankAccounts: [BankAccount]) {
		bankAccountViewModels = bankAccounts.map {
			let bankAccountCellViewModel = BankAccountCellViewModel(model: $0)
			bankAccountCellViewModel.delegate = self
			return bankAccountCellViewModel
		}
	}

	private func createNewBankAccount() {
		let bankAccount = BankAccount(accountId: "777", balance: 777)
		add(bankAccount: bankAccount)

//		onDidStartRequest?()
//		firstly {
//			dependencies.bankAccountsService.create()
//		}.ensure {
//			self.onDidFinishRequest?()
//		}.done { bankAccount in
//			self.add(bankAccount: bankAccount)
//		}.catch { error in
//			self.onDidReceiveError?(error)
//		}
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
		if let index = bankAccounts.firstIndex(where: { $0.accountId == bankAccount.accountId }) {
			bankAccounts.remove(at: index)
			handle(bankAccounts)
		}
	}
}
