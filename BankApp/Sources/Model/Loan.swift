//
//  Loan.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct Loan {
	let id: Int64
	let debt: Double
	let amount: Double
	let period: Int
	let rate: LoanRate
	let accountDebitingId: Int64
}

extension Loan: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id, rate, amount, period = "loanPeriod", debt, accountDebitingId
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		id = try container.decode(Int64.self, forKey: .id)
		debt = try container.decode(Double.self, forKey: .debt)
		amount = try container.decode(Double.self, forKey: .amount)
		period = try container.decode(Int.self, forKey: .period)
		rate = try container.decode(LoanRate.self, forKey: .rate)
		accountDebitingId = try container.decode(Int64.self, forKey: .accountDebitingId)
	}
}

struct LoanRate {
	let id: Int64
	let name: String
	let rate: Int
}

extension LoanRate: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id = "loanId", name, rate
	}

	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)

		id = try container.decode(Int64.self, forKey: .id)
		name = try container.decode(String.self, forKey: .name)
		rate = try container.decode(Int.self, forKey: .rate)
	}
}
