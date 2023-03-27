//
//  AuthViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit
import SafariServices

final class AuthViewController: SFSafariViewController {
	private let viewModel: AuthViewModel

	init(viewModel: AuthViewModel, authPageURL: URL) {
		self.viewModel = viewModel
		super.init(url: authPageURL, configuration: .init())
	}
}
