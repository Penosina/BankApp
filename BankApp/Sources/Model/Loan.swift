//
//  Loan.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct Loan: Decodable {
	let id: String
	let rate: LoanRate
	let sum: Double
	let payment: String
	let period: Date
}

struct LoanRate: Decodable {
	let nameRate: String
	let rate: String
	let minPayment: Double
}
