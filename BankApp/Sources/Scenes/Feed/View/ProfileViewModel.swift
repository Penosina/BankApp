//
//  ProfileViewModel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 01.03.2023.
//

import Foundation

final class ProfileViewModel {
	var nickname: String {
		model
	}

	private let model: String

	init(model: String) {
		self.model = model
	}
}
