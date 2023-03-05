//
//  ImageAsset.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

enum ImageAsset: String {
	case greenBank = "greenbank"
	case feed
	case history = "operationHistory"
	case logout
	case arrowRight
	case avatarPlaceholder
	case bankAccount
	case loan
	case transferIn = "in"
	case transferOut = "out"
}

extension UIImage {
	convenience init?(_ asset: ImageAsset) {
		self.init(named: asset.rawValue)
	}
}
