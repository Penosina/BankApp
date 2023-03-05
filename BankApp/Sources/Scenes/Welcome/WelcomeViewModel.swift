//
//  WelcomeViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import Foundation

protocol WelcomeViewModelDelegate: AnyObject {
	func welcomeViewModelDidRequestToShowAuth()
}

final class WelcomeViewModel {
	weak var delegate: WelcomeViewModelDelegate?

	func didTapStartButton() {
		delegate?.welcomeViewModelDidRequestToShowAuth()
	}
}
