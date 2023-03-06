//
//  FeedViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

final class FeedViewController: UIViewController, NavigationBarHiding, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let profileView = ProfileView()
	private let showBankAccountListButton = GrayRoundedButton()
	private let showLoansButton = GrayRoundedButton()
	private let logoutButton = GrayRoundedButton()

	private let viewModel: FeedViewModel

	@objc
	private func onShowBankAccountListButtonTap() {
		viewModel.didRequestToShowBankAccountList()
	}

	@objc
	private func onShowLoanListButtonTap() {
		viewModel.didRequestToShowLoanList()
	}

	init(viewModel: FeedViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		bindToViewModel()
		viewModel.start()
	}

	private func setup() {
		setupScrollView()
		setupContentStackView()
		setupProfileView()
		setupShowBankAccountsButton()
		setupShowCreditsButton()
		setupLogoutButton()
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
			make.top.bottom.equalTo(scrollView.contentLayoutGuide).inset(24)
		}
		contentStackView.axis = .vertical
		contentStackView.spacing = 24
	}

	private func setupProfileView() {
		contentStackView.addArrangedSubview(profileView)
	}

	private func setupShowBankAccountsButton() {
		contentStackView.addArrangedSubview(showBankAccountListButton)
		showBankAccountListButton.setTitle("Счета", for: .normal)
		showBankAccountListButton.imageAsset = .bankAccount
		showBankAccountListButton.addTarget(self,
											action: #selector(onShowBankAccountListButtonTap),
											for: .touchUpInside)
	}

	private func setupShowCreditsButton() {
		contentStackView.addArrangedSubview(showLoansButton)
		showLoansButton.setTitle("Кредиты", for: .normal)
		showLoansButton.imageAsset = .loan
		showLoansButton.addTarget(self,
								  action: #selector(onShowLoanListButtonTap),
								  for: .touchUpInside)
	}

	private func setupLogoutButton() {
		contentStackView.addArrangedSubview(logoutButton)
		logoutButton.setTitle("Выйти", for: .normal)
		logoutButton.imageAsset = .logout
		logoutButton.shouldShowArrow = false
	}

	private func bindToViewModel() {
		viewModel.onDidStartGetProfileRequest = { [weak self] in
			self?.profileView.activityIndicatorView.startAnimating()
		}

		viewModel.onDidFinishGetProfileRequest = { [weak self] in
			self?.profileView.activityIndicatorView.stopAnimating()
		}

		viewModel.didUpdateProfile = { [weak self] in
			self?.profileView.configure(with: self?.viewModel.profileViewModel)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
