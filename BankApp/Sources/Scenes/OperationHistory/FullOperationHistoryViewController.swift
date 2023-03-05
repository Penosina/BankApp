//
//  FullOperationHistoryViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

final class FullOperationHistoryViewController: UIViewController, NavigationBarHiding, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let viewModel: FullOperationHistoryViewModel

	init(viewModel: FullOperationHistoryViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	private func setup() {
		setupActivityIndicatorView()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
