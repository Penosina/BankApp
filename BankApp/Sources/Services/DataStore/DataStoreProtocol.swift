//
//  DataStoreProtocol.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

protocol DataStoreProtocol: AnyObject {
	var tokens: AuthTokenPair? { get set }
}
