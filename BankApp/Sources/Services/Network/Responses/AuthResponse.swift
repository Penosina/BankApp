//
//  AuthResponse.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 25.03.2023.
//

import Foundation

struct AuthResponse: Codable {
	let tokens: AuthTokenPair
}
