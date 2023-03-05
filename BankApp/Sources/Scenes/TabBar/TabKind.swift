//
//  TabKind.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

enum TabKind {
	case feed, history

	var icon: UIImage? {
		switch self {
		case .feed:
			return .init(.feed)
		case .history:
			return .init(.history)
		}
	}

	var title: String? {
		switch self {
		case .feed:
			return "Главная"
		case .history:
			return "История"
		}
	}
}
