//
//  OperationViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class OperationViewModel {
	var imageAsset: ImageAsset {
		switch operation.type {
		case .in:
			return .transferIn
		case .out:
			return .transferOut
		case .transfer:
			return .transfer
		}
	}

	var imageBackgroundColor: UIColor? {
		switch operation.type {
		case .in:
			return .accentPurple
		case .out:
			return .outTransfer
		case .transfer:
			return .magenta
		}
	}

	var text: String {
		"\(operation.value) ₽"
	}

	var inAccountNumber: String? {
		if let accountReplenishmentId = operation.accountReplenishmentId {
			return "\(accountReplenishmentId)"
		}
		return nil
	}

	var outAccountNumber: String? {
		if let accountDebitingId = operation.accountDebitingId {
			return "\(accountDebitingId)"
		}
		return nil
	}

	var date: String {
		operation.executeDate
	}

	private let operation: Operation

	init(operation: Operation) {
		self.operation = operation
	}
}
