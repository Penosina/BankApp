//
//  GrayRoundedButton.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 01.03.2023.
//

import UIKit


final class GrayRoundedButton: UIButton {
	private let contentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .horizontal
		stackView.spacing = 20
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

	private var shouldShowArrow = false {
		didSet {
			arrowImageView.isHidden = shouldShowArrow == false
		}
	}

	override func setTitle(_ title: String?, for state: UIControl.State) {
		textLabel.text = title
	}

	init() {
		super.init(frame: .zero)
		setup()
	}

	func configure(with imageAsset: ImageAsset, showArrow: Bool = true) {
		shouldShowArrow = showArrow
		imageIconView.imageAsset = imageAsset
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
			make.centerY.equalToSuperview()
		}
	}

	private func setupImageIconView() {
		contentStackView.addArrangedSubview(imageIconView)
	}

	private func setupTextLabel() {
		contentStackView.addArrangedSubview(textLabel)
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
