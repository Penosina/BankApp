//
//  OverduePaymentViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 17.04.2023.
//

import Foundation

final class OverduePaymentViewModel {
	typealias Dependencies = HasLoansService

	private let dependencies: Dependencies

	init(dependencies: Dependencies) {
		self.dependencies = dependencies
	}

	func start() {
		getOverduePayments()
	}

	private func getOverduePayments() {

	}
}
