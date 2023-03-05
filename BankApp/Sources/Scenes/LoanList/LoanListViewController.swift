//
//  LoanListViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class LoanListViewController: UIViewController, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let createNewLoanButton = CommonButton()

	private let viewModel: LoanListViewModel

	@objc
	private func createNewLoan() {

	}

	init(viewModel: LoanListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	private func setup() {
		title = "Мои кредиты"

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
			make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(16)
			make.top.equalTo(scrollView.contentLayoutGuide).inset(24)
			make.bottom.equalTo(scrollView.contentLayoutGuide).inset(60)
		}
		contentStackView.axis = .vertical
		contentStackView.spacing = 24
	}

	private func setupCreateLoanButton() {
		contentStackView.addArrangedSubview(createNewLoanButton)
		createNewLoanButton.setTitle("Взять кредит", for: .normal)
		createNewLoanButton.addTarget(self,
									  action: #selector(createNewLoan),
									  for: .touchUpInside)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
