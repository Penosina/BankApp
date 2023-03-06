//
//  TakeLoanViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

final class TakeLoanViewController: UIViewController, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let amountTextField = TextField()
	private let periodTextField = TextField()
	private let selectWithdrawalAccountButton = GrayRoundedButton()
	private let selectReplenishAccountButton = GrayRoundedButton()
	private let submitButton = CommonButton()

	private let viewModel: TakeLoanViewModel

	@objc
	private func selectReplenishAccount() {
		viewModel.selectReplenishAccount()
	}

	@objc
	private func selectWithdrawalAccount() {
		viewModel.selectWithdrawalAccount()
	}

	@objc
	private func submit() {
		let amount = amountTextField.text
		let period = periodTextField.text
		viewModel.takeLoan(amountString: amount, periodString: period)
	}

	init(viewModel: TakeLoanViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
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
		setupPeriodTextField()
		setupWithdrawalAccountButton()
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

		amountTextField.setPlaceholder("Сумма кредита")
		amountTextField.keyboardType = .decimalPad
	}

	private func setupPeriodTextField() {
		contentStackView.addArrangedSubview(periodTextField)
		periodTextField.snp.makeConstraints { make in
			make.height.equalTo(56)
		}

		periodTextField.setPlaceholder("Срок кредитования")
		periodTextField.keyboardType = .decimalPad
	}

	private func setupWithdrawalAccountButton() {
		contentStackView.addArrangedSubview(selectWithdrawalAccountButton)
		selectWithdrawalAccountButton.systemImageAsset = .banknote
		selectWithdrawalAccountButton.setTitle("Выберите аккаунт для списания", for: .normal)
		selectWithdrawalAccountButton.addTarget(self,
												action: #selector(selectWithdrawalAccount),
												for: .touchUpInside)
	}
	
	private func setupReplenishAccountButton() {
		contentStackView.addArrangedSubview(selectReplenishAccountButton)
		selectReplenishAccountButton.systemImageAsset = .banknote
		selectReplenishAccountButton.setTitle("Выберите аккаунт для зачисления", for: .normal)
		selectReplenishAccountButton.addTarget(self,
											   action: #selector(selectReplenishAccount),
											   for: .touchUpInside)
	}

	private func setupSubmitButton() {
		contentStackView.addArrangedSubview(submitButton)
		submitButton.setTitle("Взять кредит", for: .normal)
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

		viewModel.onDidUpdateWithdrawalAccount = { [weak self] in
			self?.selectWithdrawalAccountButton.setTitle(self?.viewModel.withdrawalAccountButtonTitle,
														 for: .normal)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
