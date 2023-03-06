//
//  LoanBankAccountView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

final class LoanBankAccountView: UIView, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()
	private let bankAccountLabel = TwoLabel()

	private let viewModel: LoanBankAccountViewModel

	init(viewModel: LoanBankAccountViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		setup()
	}

	func configure() {
		bindToViewModel()
		viewModel.start()
	}

	private func setup() {
		backgroundColor = .accentGray
		layer.cornerRadius = 16
		layer.masksToBounds = true

		setupBankAccountLabel()
		setupActivityIndicatorView()
	}

	private func setupBankAccountLabel() {
		addSubview(bankAccountLabel)
		bankAccountLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(16)
		}

		bankAccountLabel.title = "БАЛАНС"
		bankAccountLabel.subtitle = "Грузимся..."
	}

	private func bindToViewModel() {
		viewModel.onDidStartRequest = { [weak self] in
			self?.activityIndicatorView.startAnimating()
		}

		viewModel.onDidFinishRequest = { [weak self] in
			self?.activityIndicatorView.stopAnimating()
		}

		viewModel.onDidLoadData = { [weak self] in
			self?.bankAccountLabel.subtitle = self?.viewModel.balance
		}
		
		viewModel.onDidReceiveError = { [weak self] _ in
			self?.bankAccountLabel.subtitle = self?.viewModel.balance
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
