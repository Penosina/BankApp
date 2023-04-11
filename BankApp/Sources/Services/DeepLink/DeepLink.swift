//
//  DeepLink.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 25.03.2023.
//

import Foundation

enum DeepLink {
	case oAuth(URL)

	static let scheme = "mobile"
	static let host = "localhost:8765/client/"

	init?(url: URL) {
		guard url.scheme == Self.scheme, url.host == Self.host else { return nil }

		switch url.path {
		case "/auth/success":
			self = .oAuth(url)
		default:
			return nil
		}
	}
}
