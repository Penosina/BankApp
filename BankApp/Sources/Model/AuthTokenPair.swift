//
//  AuthTokenPair.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation
import Alamofire

struct AuthTokenPair: Codable, AuthenticationCredential {
	enum CodingKeys: String, CodingKey {
		case accessToken
		case accessTokenExpirationTime = "accessTokenExpiresIn"
		case refreshToken
		case refreshTokenExpirationTime = "refreshTokenExpiresIn"
	}

	let accessToken: String
	let accessTokenExpirationTime: TimeInterval
	let refreshToken: String
	let refreshTokenExpirationTime: TimeInterval

	var requiresRefresh: Bool {
		Date(timeIntervalSinceNow: 60).timeIntervalSince1970 > accessTokenExpirationTime
	}
}
