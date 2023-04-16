//
//  LoanCalculatorViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

final class LoanCalculatorViewController: UIViewController, NavigationBarHiding, ActivityIndicatorViewDisplaying, AlertShowing {
	let activityIndicatorView = ActivityIndicatorView()

	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private lazy var loanBankAccountView = LoanBankAccountView(viewModel: viewModel.loanBankAccountViewModel)
	private let amountTextField = TextField()
	private let submitButton = CommonButton()

	private let viewModel: LoanCalculatorViewModel

	@objc
	private func submit() {
		viewModel.submit(amountString: amountTextField.text)
	}

	init(viewModel: LoanCalculatorViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindToViewModel()
		loanBankAccountView.configure()
	}

	private func setup() {
		view.backgroundColor = .black
		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true

		setupScrollView()
		setupContentStackView()
		setupLoanBankAccountView()
		setupAmountTextField()
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

	private func setupLoanBankAccountView() {
		contentStackView.addArrangedSubview(loanBankAccountView)
	}

	private func setupAmountTextField() {
		contentStackView.addArrangedSubview(amountTextField)
		amountTextField.snp.makeConstraints { make in
			make.height.equalTo(56)
		}

		amountTextField.setPlaceholder("Сумма")
		amountTextField.keyboardType = .decimalPad
	}

	private func setupSubmitButton() {
		contentStackView.addArrangedSubview(submitButton)
		submitButton.setTitle("Оплатить", for: .normal)
		submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
	}

	private func bindToViewModel() {
		viewModel.onDidStartRequest = { [weak self] in
			self?.activityIndicatorView.startAnimating()
		}

		viewModel.onDidFinishRequest = { [weak self] in
			self?.activityIndicatorView.stopAnimating()
		}

		viewModel.onDidReceiveError = { [weak self] _ in
			self?.showAlert(title: "Операция не может быть выполнена!")
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
