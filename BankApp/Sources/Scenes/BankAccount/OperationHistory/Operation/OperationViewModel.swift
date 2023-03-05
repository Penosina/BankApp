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
		}
	}

	var imageBackgroundColor: UIColor? {
		switch operation.type {
		case .in:
			return .accentPurple
		case .out:
			return .outTransfer
		}
	}

	var text: String {
		switch operation.type {
		case .in:
			return "+\(operation.value) ₽"
		case .out:
			return "-\(operation.value) ₽"
		}
	}

	var date: String {
//		let dateFormatter = DateFormatter()
//		dateFormatter.dateFormat = "dd MMM yyyy, HH:mm"
//		dateFormatter.timeZone = .current
//		return dateFormatter.string(from: operation.executeDate)
		operation.executeDate
	}

	private let operation: Operation

	init(operation: Operation) {
		self.operation = operation
	}
}
