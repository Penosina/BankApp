//
//  OperationView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class OperationView: UIView {
	private let imageIconView = ImageIconView()
	private let stackView = UIStackView()
	private let textLabel = UILabel()
	private let inAccountNumberLabel = UILabel()
	private let outAccountNumberLabel = UILabel()
	private let dateLabel = UILabel()

	private let viewModel: OperationViewModel

	init(viewModel: OperationViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		setup()
	}

	private func setup() {
		backgroundColor = .accentGray
		layer.cornerRadius = 16
		layer.masksToBounds = true

		setupImageIconView()
		setupStackView()
		setupTextLabel()
		setupInAccountNumberLabel()
		setupOutAccountNumberLabel()
		setupDateLabel()
	}

	private func setupImageIconView() {
		addSubview(imageIconView)
		imageIconView.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(8)
			make.centerY.equalToSuperview()
		}
		imageIconView.imageAsset = viewModel.imageAsset
		imageIconView.backgroundColor = viewModel.imageBackgroundColor
	}

	private func setupStackView() {
		addSubview(stackView)
		stackView.snp.makeConstraints { make in
			make.leading.equalTo(imageIconView.snp.trailing).offset(20)
			make.trailing.equalToSuperview().inset(20)
			make.top.bottom.equalToSuperview().inset(8)
		}
		stackView.spacing = 5
		stackView.axis = .vertical
	}

	private func setupTextLabel() {
		stackView.addArrangedSubview(textLabel)
		textLabel.font = .body
		textLabel.textColor = .white
		textLabel.text = viewModel.text
	}

	private func setupInAccountNumberLabel() {
		if let inAccountNumber = viewModel.inAccountNumber {
			stackView.addArrangedSubview(inAccountNumberLabel)
			inAccountNumberLabel.text = "Счет получателя: №\(inAccountNumber)"
			inAccountNumberLabel.font = .body
			inAccountNumberLabel.textColor = .white
		}
	}

	private func setupOutAccountNumberLabel() {
		if let outAccountNumber = viewModel.outAccountNumber {
			stackView.addArrangedSubview(outAccountNumberLabel)
			outAccountNumberLabel.text = "Счет отправителя: №\(outAccountNumber)"
			outAccountNumberLabel.font = .body
			outAccountNumberLabel.textColor = .white
		}
	}

	private func setupDateLabel() {
		stackView.addArrangedSubview(dateLabel)
		dateLabel.font = .footnote
		dateLabel.textColor = .white.withAlphaComponent(0.6)
		dateLabel.textAlignment = .right
		dateLabel.text = viewModel.date
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
