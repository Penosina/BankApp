//
//  LoanRate.swift
//  BankApp
//
//  Created by Илья Абросимов on 07.03.2023.
//

import Foundation

struct LoanRate: Decodable {
	let id: Int64
	let name: String
	let rate: Int
}
