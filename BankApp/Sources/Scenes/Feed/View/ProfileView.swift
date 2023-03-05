//
//  ProfileView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 01.03.2023.
//

import UIKit

final class ProfileView: UIView, ActivityIndicatorViewDisplaying {
	let activityIndicatorView = ActivityIndicatorView()

	private let avatarImageView = UIImageView()
	private let nicknameLabel = UILabel()

	private var viewModel: ProfileViewModel?

	init() {
		super.init(frame: .zero)
		setup()
	}

	func configure(with viewModel: ProfileViewModel?) {
		activityIndicatorView.stopAnimating()

		self.viewModel = viewModel
		nicknameLabel.text = viewModel?.nickname
	}

	private func setup() {
		setupAvatarImageView()
		setupNicknameLabel()
		setupActivityIndicatorView()

		backgroundColor = .accentGray
		layer.cornerRadius = 16
		layer.masksToBounds = true
	}

	private func setupAvatarImageView() {
		addSubview(avatarImageView)
		avatarImageView.snp.makeConstraints { make in
			make.size.equalTo(80)
			make.top.equalToSuperview().inset(20)
			make.centerX.equalToSuperview()
		}

		avatarImageView.layer.cornerRadius = 16
		avatarImageView.layer.masksToBounds = true
		avatarImageView.image = UIImage(.avatarPlaceholder)?.withTintColor(.white)
		avatarImageView.contentMode = .scaleAspectFill
	}

	private func setupNicknameLabel() {
		addSubview(nicknameLabel)
		nicknameLabel.snp.makeConstraints { make in
			make.leading.trailing.equalToSuperview().inset(16)
			make.top.equalTo(avatarImageView.snp.bottom).offset(20)
			make.bottom.equalToSuperview().inset(20)
		}

		nicknameLabel.numberOfLines = 1
		nicknameLabel.font = .header1
		nicknameLabel.textColor = .white
		nicknameLabel.textAlignment = .center
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
