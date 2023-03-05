//
//  CommonButton.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

final class CommonButton: UIButton {
	override var isHighlighted: Bool {
		didSet {
			updateAppearance()
		}
	}

	override var isEnabled: Bool {
		didSet {
			updateAppearance()
		}
	}

	init() {
		super.init(frame: .zero)
		setup()
	}

	private func setup() {
		snp.makeConstraints { make in
			make.height.equalTo(56)
		}
		backgroundColor = .lightGreen
		layer.cornerRadius = 16
		setTitleColor(.black, for: .normal)
		titleLabel?.font = .body
	}

	private func updateAppearance() {
		guard isEnabled else {
			backgroundColor = .lightGreen
			return
		}

		backgroundColor = isHighlighted ? .lightGray : .lightGreen
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
