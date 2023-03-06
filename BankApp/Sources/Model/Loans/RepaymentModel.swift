//
//  RepaymentModel.swift
//  BankApp
//
//  Created by Илья Абросимов on 07.03.2023.
//

import Foundation

enum RepaymentModel {
	case closed
	case open(loan: Loan)
}

extension RepaymentModel: Decodable {
	private enum CodingKeys: String, CodingKey {
		case hasData
	}
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		
		let hasData = try container.decode(Bool.self, forKey: .hasData)
		if hasData {
			self = .open(loan: try Loan(from: decoder))
		} else {
			self = .closed
		}
	}
}
