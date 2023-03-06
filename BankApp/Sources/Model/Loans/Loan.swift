//
//  Loan.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct Loan {
	let id: Int64
	let rate: LoanRate
	let period: Int
	let amount: Double
	let accountDebitingId: Int64
	let debt: Double
}

extension Loan: Decodable {
	private enum CodingKeys: String, CodingKey {
		case id, rate, amount = "loanAmount", period = "loanPeriod", debt, accountDebitingId
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
