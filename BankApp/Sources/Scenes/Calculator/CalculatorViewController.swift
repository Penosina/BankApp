//
//  CalculatorViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class CalculatorViewController: UIViewController, NavigationBarHiding, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let scrollView = UIScrollView()
	private let contentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20
		return stackView
	}()
	private let balanceView: UIView = {
		let view = UIView()
		view.backgroundColor = .accentGray
		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true
		return view
	}()
	private let balanceLabel: UILabel = {
		let label = UILabel()
		label.font = .header2
		label.textColor = .white
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()
	private let textField = TextField()
	private let submitButton = CommonButton()

	private let viewModel: CalculatorViewModel

	@objc
	private func submit() {
		viewModel.onDidButtonTapped(amountString: textField.text)
	}

	@objc
	func textFieldDidChange(_ textField: UITextField) {
		guard let currentText = textField.text else { return }

		if currentText.filter({ $0 == "." }).count == 2 {
			textField.text = String(currentText.dropLast())
			return
		}

		if currentText.count > 1, currentText.first == "0", currentText.hasPrefix("0.") == false {
			textField.text = String(currentText.dropFirst())
			return
		}

		if currentText.contains(".") {
			let parts = currentText.components(separatedBy: ".")
			if parts[1].count > 2 {
				textField.text = String(currentText.dropLast())
			}
			return
		}

		if currentText == "." {
			textField.text = "0."
		}
	}

	init(viewModel: CalculatorViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		textField.becomeFirstResponder()
		bindToViewModel()
	}

	private func setup() {
		view.backgroundColor = .black
		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true

		setupScrollView()
		setupContentStackView()
		setupBalanceView()
		setupBalanceLabel()
		setupTextField()
		setupSubmitButton()
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
	}

	private func setupBalanceView() {
		contentStackView.addArrangedSubview(balanceView)
		balanceView.snp.makeConstraints { make in
			make.height.equalTo(82)
		}
	}

	private func setupBalanceLabel() {
		balanceView.addSubview(balanceLabel)
		balanceLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(8)
		}
		balanceLabel.text = viewModel.balanceTitle
	}

	private func setupTextField() {
		contentStackView.addArrangedSubview(textField)
		textField.snp.makeConstraints { make in
			make.height.equalTo(56)
		}
		textField.setPlaceholder("Сумма от 0,01 ₽")
		textField.keyboardType = .decimalPad
		textField.keyboardAppearance = .dark
		textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
	}

	private func setupSubmitButton() {
		contentStackView.addArrangedSubview(submitButton)
		submitButton.setTitle(viewModel.buttonTitle, for: .normal)
		submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
	}

	private func bindToViewModel() {
		viewModel.onDidStartRequest = { [weak self] in
			self?.activityIndicatorView.startAnimating()
		}

		viewModel.onDidFinishRequest = { [weak self] in
			self?.activityIndicatorView.stopAnimating()
		}

		viewModel.onDidLoadData = { [weak self] in
			self?.balanceLabel.text = self?.viewModel.balanceTitle
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
