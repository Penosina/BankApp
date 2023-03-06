//
//  TwoLabel.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

final class TwoLabel: UIView {
	var title: String? = nil {
		didSet {
			titleLabel.text = title
		}
	}

	var subtitle: String? = nil {
		didSet {
			subtitleLabel.text = subtitle
		}
	}

	private let contentStackView = UIStackView()
	private let titleLabel = UILabel()
	private let subtitleLabel = UILabel()

	init() {
		super.init(frame: .zero)
		setup()
	}

	private func setup() {
		setupContentStackView()
		setupTitleLabel()
		setupSubtitleLabel()
	}

	private func setupContentStackView() {
		addSubview(contentStackView)
		contentStackView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}

		contentStackView.axis = .vertical
		contentStackView.spacing = 6
	}

	private func setupTitleLabel() {
		contentStackView.addArrangedSubview(titleLabel)
		titleLabel.font = .body
		titleLabel.textColor = .white.withAlphaComponent(0.6)
	}

	private func setupSubtitleLabel() {
		contentStackView.addArrangedSubview(subtitleLabel)
		subtitleLabel.font = .body
		subtitleLabel.textColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
