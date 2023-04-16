//
//  Operation.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct Operation: Decodable {
	let value: String
	let executeDate: String
	let type: OperationType
	let accountReplenishmentId: Int64?
	let accountDebitingId: Int64?
}

enum OperationType: String, Decodable {
	case `in` = "ACCOUNT_REPLENISHMENT", out = "WITHDRAWAL_OF_FUNDS_FROM_ACCOUNT", transfer = "TRANSFER"
}
