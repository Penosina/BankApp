//
//  FeedViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation

protocol FeedViewModelDelegate: AnyObject {
	func feedViewModelDidRequstToShowBankAccountList()
	func feedViewModelDidRequstToShowLoanList()
}

final class FeedViewModel {
	weak var delegate: FeedViewModelDelegate?

	var didUpdateProfile: (() -> Void)?
	var onDidStartGetProfileRequest: (() -> Void)?
	var onDidFinishGetProfileRequest: (() -> Void)?

	private(set) var profileViewModel: ProfileViewModel? = ProfileViewModel(model: "Penosina")

	func start() {
		getProfile()
	}

	func didRequestToShowBankAccountList() {
		delegate?.feedViewModelDidRequstToShowBankAccountList()
	}

	func didRequestToShowLoanList() {
		delegate?.feedViewModelDidRequstToShowLoanList()
	}

	private func getProfile() {
		onDidStartGetProfileRequest?()
		onDidFinishGetProfileRequest?()
		didUpdateProfile?()
	}
}
