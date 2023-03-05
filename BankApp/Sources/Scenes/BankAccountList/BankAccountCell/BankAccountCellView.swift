//
//  BankAccountCellView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import UIKit

final class BankAccountCellView: UIView {
	private let verticalStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20
		return stackView
	}()
	private let imageIconView = ImageIconView()
	private let balanceLabel: UILabel = {
		let label = UILabel()
		label.font = .body
		label.textColor = .white
		label.numberOfLines = 1
		return label
	}()
	private let accountNameLabel: UILabel = {
		let label = UILabel()
		label.font = .body
		label.textColor = .white
		label.numberOfLines = 1
		return label
	}()

	private let viewModel: BankAccountCellViewModel

	@objc
	private func didTap() {
		viewModel.didTap()
	}

	init(viewModel: BankAccountCellViewModel) {
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
		setupBalanceLabel()
		setupAccountNameLabelLabel()
	}

	private func setupImageIconView() {
		addSubview(imageIconView)
		imageIconView.snp.makeConstraints { make in
			make.top.leading.equalToSuperview().inset(20)
		}
		imageIconView.systemImageAsset = .banknote
	}

	private func setupVerticalStackView() {
		addSubview(verticalStackView)

		verticalStackView.snp.makeConstraints { make in
			make.leading.equalTo(imageIconView.snp.trailing).offset(20)
			make.top.bottom.trailing.equalToSuperview().inset(20)
		}
	}

	private func setupBalanceLabel() {
		verticalStackView.addArrangedSubview(balanceLabel)
		balanceLabel.text = viewModel.balance
	}

	private func setupAccountNameLabelLabel() {
		verticalStackView.addArrangedSubview(accountNameLabel)
		accountNameLabel.text = viewModel.accountName
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
