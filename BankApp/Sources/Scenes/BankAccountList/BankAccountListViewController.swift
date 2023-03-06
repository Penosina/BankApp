//
//  BankAccountListViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 02.03.2023.
//

import UIKit

final class BankAccountListViewController: UIViewController, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let createNewBankAccountButton = CommonButton()

	private let viewModel: BankAccountListViewModel

	@objc
	private func createNewBankAccount() {
		viewModel.didTapCreateNewBankAccountButton()
	}

	init(viewModel: BankAccountListViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		bindToViewModel()
		viewModel.start()
	}

	func setCreateNewBankAccountButtonHidden(_ isHidden: Bool) {
		createNewBankAccountButton.isHidden = isHidden
	}

	private func setup() {
		title = "Мои счета"
		view.backgroundColor = .black
		
		setupScrollView()
		setupContentStackView()
		setupActivityIndicatorView()
		setupCreateNewBankAccountButton()
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

	private func setupCreateNewBankAccountButton() {
		contentStackView.addArrangedSubview(createNewBankAccountButton)
		createNewBankAccountButton.setTitle("Открыть новый счёт", for: .normal)
		createNewBankAccountButton.addTarget(self,
											 action: #selector(createNewBankAccount),
											 for: .touchUpInside)
	}

	private func updateBankAccounts() {
		contentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

		viewModel.bankAccountViewModels.forEach { cellViewModel in
			let view = BankAccountCellView(viewModel: cellViewModel)
			contentStackView.addArrangedSubview(view)
		}
		setupCreateNewBankAccountButton()
	}

	private func bindToViewModel() {
		viewModel.onDidLoadData = { [weak self] in
			self?.updateBankAccounts()
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
