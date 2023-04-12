//
//  MakeTransferViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 12.04.2023.
//

import UIKit

final class MakeTransferViewController: UIViewController, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()
	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let amountTextField = TextField()
	private let withdrawalAccountNumberLabel = TwoLabel()
	private let withdrawalAccountBalanceLabel = TwoLabel()
	private let selectReplenishAccountButton = GrayRoundedButton()
	private let submitButton = CommonButton()

	private let viewModel: MakeTransferViewModel

	@objc
	private func selectReplenishAccount() {
		viewModel.selectReplenishAccount()
	}

	@objc
	private func submit() {
		let amount = amountTextField.text
		viewModel.makeTransfer(amountString: amount)
	}

	init(viewModel: MakeTransferViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindToViewModel()
	}

	private func setup() {
		view.backgroundColor = .black
		view.layer.cornerRadius = 16

		setupScrollView()
		setupContentStackView()
		setupAmountTextField()
		setupWithdrawalAccountNumberLabel()
		setupWithdrawalAccountBalanceLabel()
		setupReplenishAccountButton()
		setupSubmitButton()
		setupActivityIndicatorView()
	}

	private func setupScrollView() {
		view.addSubview(scrollView)
		scrollView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	private func setupContentStackView() {
		scrollView.addSubview(contentStackView)
		contentStackView.snp.makeConstraints { make in
			make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(20)
			make.top.bottom.equalTo(scrollView.contentLayoutGuide).inset(20)
		}

		contentStackView.axis = .vertical
		contentStackView.spacing = 20
	}

	private func setupAmountTextField() {
		contentStackView.addArrangedSubview(amountTextField)
		amountTextField.snp.makeConstraints { make in
			make.height.equalTo(56)
		}

		amountTextField.setPlaceholder("Сумма перевода")
		amountTextField.keyboardType = .decimalPad
	}

	private func setupWithdrawalAccountNumberLabel() {
		contentStackView.addArrangedSubview(withdrawalAccountNumberLabel)
		withdrawalAccountNumberLabel.title = "Номер счета списания"
		withdrawalAccountNumberLabel.subtitle = viewModel.withdrawalAccountNumber
	}

	private func setupWithdrawalAccountBalanceLabel() {
		contentStackView.addArrangedSubview(withdrawalAccountBalanceLabel)
		withdrawalAccountBalanceLabel.title = "Баланс счета списания"
		withdrawalAccountBalanceLabel.subtitle = viewModel.withdrawalAccountBalance
	}

	private func setupReplenishAccountButton() {
		contentStackView.addArrangedSubview(selectReplenishAccountButton)
		selectReplenishAccountButton.systemImageAsset = .banknote
		selectReplenishAccountButton.setTitle("Выберите счет для зачисления", for: .normal)
		selectReplenishAccountButton.addTarget(self,
											   action: #selector(selectReplenishAccount),
											   for: .touchUpInside)
	}

	private func setupSubmitButton() {
		contentStackView.addArrangedSubview(submitButton)
		submitButton.setTitle("Перевести", for: .normal)
		submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
	}

	private func bindToViewModel() {
		viewModel.onDidStartRequest = { [weak self] in
			self?.activityIndicatorView.startAnimating()
		}

		viewModel.onDidFinishRequest = { [weak self] in
			self?.activityIndicatorView.stopAnimating()
		}

		viewModel.onDidUpdateReplenishAccount = { [weak self] in
			self?.selectReplenishAccountButton.setTitle(self?.viewModel.replenishAccountButtonTitle,
														for: .normal)
		}
	}
}
