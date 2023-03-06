//
//  GrayRoundedButton.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 01.03.2023.
//

import UIKit


final class GrayRoundedButton: UIButton {
	var shouldShowArrow = true {
		didSet {
			arrowImageView.isHidden = shouldShowArrow == false
		}
	}

	var imageAsset: ImageAsset = .loan {
		didSet {
			imageIconView.imageAsset = imageAsset
		}
	}

	var systemImageAsset: SystemImageAsset = .creditcard {
		didSet {
			imageIconView.systemImageAsset = systemImageAsset
		}
	}

	var titleFont: UIFont? = .body {
		didSet {
			textLabel.font = titleFont
		}
	}

	private let contentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 20
		stackView.isUserInteractionEnabled = false
		return stackView
	}()
	private let imageIconView = ImageIconView()
	private let arrowImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.contentMode = .scaleAspectFit
		imageView.image = UIImage(.arrowRight)
		return imageView
	}()
	private let textLabel: UILabel = {
		let label = UILabel()
		label.font = .body
		label.textColor = .white
		return label
	}()

	override func setTitle(_ title: String?, for state: UIControl.State) {
		textLabel.text = title
	}

	init() {
		super.init(frame: .zero)
		setup()
	}

	private func setup() {
		snp.makeConstraints { make in
			make.height.equalTo(60)
		}

		layer.cornerRadius = 16
		layer.masksToBounds = true
		backgroundColor = .accentGray
		titleLabel?.isHidden = true

		setupContentStackView()
		setupImageIconView()
		setupTextLabel()
		setupArrowImageView()
	}

	private func setupContentStackView() {
		addSubview(contentStackView)
		contentStackView.snp.makeConstraints { make in
			make.leading.equalToSuperview().inset(20)
			make.top.bottom.equalToSuperview().inset(8)
			make.trailing.equalToSuperview().inset(20)
		}
	}

	private func setupImageIconView() {
		contentStackView.addArrangedSubview(imageIconView)
	}

	private func setupTextLabel() {
		contentStackView.addArrangedSubview(textLabel)
		textLabel.numberOfLines = 0
	}

	private func setupArrowImageView() {
		addSubview(arrowImageView)
		arrowImageView.snp.makeConstraints { make in
			make.top.bottom.trailing.equalToSuperview().inset(18)
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
