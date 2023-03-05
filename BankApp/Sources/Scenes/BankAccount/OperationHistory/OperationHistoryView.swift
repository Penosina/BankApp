//
//  OperationHistoryView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class OperationHistoryView: UIView, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let titleLabel: UILabel = {
		let label = UILabel()
		label.font = .header2
		label.textColor = .white
		return label
	}()
	private let operationsStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20
		return stackView
	}()
	private let viewModel: OperationHistoryViewModel

	init(viewModel: OperationHistoryViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		setup()
	}

	func configure() {
		bindToViewModel()
		viewModel.start()
	}

	private func setup() {
		backgroundColor = .clear
		setupTitleLabel()
		setupOperationStackView()
		setupActivityIndicatorView()
	}

	private func setupTitleLabel() {
		addSubview(titleLabel)
		titleLabel.snp.makeConstraints { make in
			make.leading.top.equalToSuperview()
		}
		titleLabel.text = "История операций"
	}

	private func setupOperationStackView() {
		addSubview(operationsStackView)
		operationsStackView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview()
			make.top.equalTo(titleLabel.snp.bottom).offset(20)
		}
	}

	private func updateData() {
		operationsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

		viewModel.operationViewModels.forEach { operationViewModel in
			let view = OperationView(viewModel: operationViewModel)
			operationsStackView.addArrangedSubview(view)
		}
	}

	private func bindToViewModel() {
		viewModel.onDidLoadData = { [weak self] in
			self?.updateData()
		}

		viewModel.onDidStartRequest = { [weak self] in
			self?.activityIndicatorView.startAnimating()
		}

		viewModel.onDidFinishRequest = { [weak self] in
			self?.activityIndicatorView.stopAnimating()
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
