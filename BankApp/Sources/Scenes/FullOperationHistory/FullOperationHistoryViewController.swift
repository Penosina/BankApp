//
//  FullOperationHistoryViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

final class FullOperationHistoryViewController: UIViewController, NavigationBarHiding, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let inProgressLabel = UILabel()

	private let viewModel: FullOperationHistoryViewModel

	init(viewModel: FullOperationHistoryViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	private func setup() {
		setupInProgressLabel()
		setupActivityIndicatorView()
	}

	private func setupInProgressLabel() {
		view.addSubview(inProgressLabel)
		inProgressLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(16)
			make.centerY.equalToSuperview()
		}

		inProgressLabel.font = .header2
		inProgressLabel.textColor = .white
		inProgressLabel.numberOfLines = 0
		inProgressLabel.textAlignment = .center
		inProgressLabel.text = "Здесь могла быть история всех переводов"
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
