//
//  BankAccount.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct BankAccount {
	let accountId: String
	let balance: Double
}

extension BankAccount: Decodable {
	private enum CodingKeys: String, CodingKey {
		case accountId = "number"
		case balance = "amount"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		accountId = try container.decode(String.self, forKey: .accountId)
		balance = try container.decode(Double.self, forKey: .balance)
	}
}
