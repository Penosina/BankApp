//
//  LoanCellView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class LoanCellView: UIView {
	private let verticalStackView = UIStackView()
	private let imageIconView = ImageIconView()
	private let rateNameLabel = UILabel()
	private let additionalInfoLabel = UILabel()
	private let debtLabel = UILabel()

	private let viewModel: LoanCellViewModel

	@objc
	private func didTap() {
		viewModel.didTap()
	}

	init(viewModel: LoanCellViewModel) {
		self.viewModel = viewModel
		super.init(frame: .zero)
		setup()
	}

	private func setup() {
		let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
		addGestureRecognizer(gestureRecognizer)

		layer.cornerRadius = 16
		layer.masksToBounds = true
		backgroundColor = .accentGray

		setupImageIconView()
		setupVerticalStackView()
		setupRateNameLabel()
		setupAdditionalInfoLabelLabel()
		setupDebtLabel()
	}

	private func setupImageIconView() {
		addSubview(imageIconView)
		imageIconView.snp.makeConstraints { make in
			make.top.leading.equalToSuperview().inset(20)
		}
		imageIconView.systemImageAsset = .creditcard
	}

	private func setupVerticalStackView() {
		addSubview(verticalStackView)

		verticalStackView.snp.makeConstraints { make in
			make.leading.equalTo(imageIconView.snp.trailing).offset(20)
			make.top.bottom.trailing.equalToSuperview().inset(20)
		}

		verticalStackView.axis = .vertical
		verticalStackView.spacing = 4
	}

	private func setupRateNameLabel() {
		verticalStackView.addArrangedSubview(rateNameLabel)
		rateNameLabel.font = .body
		rateNameLabel.textColor = .white
		rateNameLabel.numberOfLines = 1
		rateNameLabel.text = viewModel.rateName
	}

	private func setupAdditionalInfoLabelLabel() {
		verticalStackView.addArrangedSubview(additionalInfoLabel)
		additionalInfoLabel.font = .footnote
		additionalInfoLabel.textColor = .white.withAlphaComponent(0.6)
		additionalInfoLabel.numberOfLines = 1
		additionalInfoLabel.text = viewModel.additionalInfo
	}

	private func setupDebtLabel() {
		verticalStackView.addArrangedSubview(debtLabel)
		debtLabel.font = .body
		debtLabel.textColor = .lightGreen
		debtLabel.numberOfLines = 1
		debtLabel.text = viewModel.debt
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
