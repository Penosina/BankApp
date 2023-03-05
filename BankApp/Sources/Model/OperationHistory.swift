//
//  OperationHistory.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import Foundation

struct OperationHistory: Decodable {
	let startDate: Date
	let endDate: Date
	let operations: [Operation]
}
