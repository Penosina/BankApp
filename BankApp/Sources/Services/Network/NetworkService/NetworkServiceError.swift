//
//  NetworkServiceError.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation

enum NetworkServiceError: LocalizedError {
	case failedToDecodeData
	case noData
	case requestFailed
	case unauthorized

	var errorDescription: String? {
		switch self {
		case .failedToDecodeData, .noData:
			return "Не удалось прочитать данные"
		case .requestFailed:
			return "Не удалось выполнить запрос"
		case .unauthorized:
			return "Необходима повторная авторизация"
		}
	}
}
