//
//  AuthViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit

final class AuthViewController: UIViewController, NavigationBarHiding {
	private let submitButton = CommonButton()

	private let viewModel: AuthViewModel

	@objc
	private func submit() {
		viewModel.auth(login: "")
	}

	init(viewModel: AuthViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindToViewModel()
	}

	private func setup() {
		setupSubmitButton()
	}

	private func setupSubmitButton() {
		view.addSubview(submitButton)
		submitButton.snp.makeConstraints { make in
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(32)
			make.leading.trailing.equalToSuperview().inset(16)
		}

		submitButton.setTitle("Войти", for: .normal)
		submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
	}

	private func bindToViewModel() {

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
