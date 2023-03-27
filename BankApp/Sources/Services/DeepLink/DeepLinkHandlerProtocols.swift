//
//  DeepLinkHandlerProtocols.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 25.03.2023.
//

import Foundation

protocol DeepLinkHandler: AnyObject {}

protocol DeepLinkOAuthHandler: DeepLinkHandler {
	func handleDeepLink(with url: URL)
}
