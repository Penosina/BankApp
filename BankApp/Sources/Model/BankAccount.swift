//
//  BankAccount.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct BankAccount {
	let id: String
	let accountNumber: String
	let balance: Double
}

extension BankAccount: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id
		case accountNumber = "number"
		case balance = "amount"
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		id = String(try container.decode(Int64.self, forKey: .id))
		accountNumber = try container.decode(String.self, forKey: .accountNumber)
		balance = try container.decode(Double.self, forKey: .balance)
	}
}
