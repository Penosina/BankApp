//
//  SystemImageAsset.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 04.03.2023.
//

import UIKit

enum SystemImageAsset: String {
	case banknote
	case creditcard
}

extension UIImage {
	convenience init?(systemAsset: SystemImageAsset) {
		self.init(systemName: systemAsset.rawValue)
	}
}
