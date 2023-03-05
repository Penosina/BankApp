//
//  WelcomeViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit

final class WelcomeViewController: UIViewController, NavigationBarHiding {
	private let welcomeLabel = UILabel()
	private let logoImageView = UIImageView()
	private let authButton = CommonButton()

	private let viewModel: WelcomeViewModel

	init(viewModel: WelcomeViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
	}

	@objc
	private func showAuth() {
		viewModel.didTapStartButton()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	private func setup() {
		setupWelcomeLabel()
		setupLogoImageView()
		setupAuthButton()
	}

	private func setupWelcomeLabel() {
		view.addSubview(welcomeLabel)
		welcomeLabel.snp.makeConstraints { make in
			make.top.equalTo(view.safeAreaLayoutGuide).inset(112)
			make.centerX.equalToSuperview()
		}

		welcomeLabel.font = .header1
		welcomeLabel.text = "Добро пожаловать!"
		welcomeLabel.textColor = .lightGreen
	}

	private func setupLogoImageView() {
		view.addSubview(logoImageView)
		logoImageView.snp.makeConstraints { make in
			make.top.equalTo(welcomeLabel.snp.bottom).offset(36)
			make.centerX.equalToSuperview()
		}

		let image = UIImage(named: "greenbank")?.withTintColor(.logoColor ?? .lightGray)
		logoImageView.image = image
		logoImageView.contentMode = .scaleAspectFit
	}

	private func setupAuthButton() {
		view.addSubview(authButton)
		authButton.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(16)
			make.bottom.equalTo(view.safeAreaLayoutGuide).inset(48)
			make.height.equalTo(56)
		}

		authButton.setTitle("Авторизоваться", for: .normal)
		authButton.addTarget(self, action: #selector(showAuth), for: .touchUpInside)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
