//
//  TextField.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class TextField: UITextField {
	private let textPadding = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)

	override func textRect(forBounds bounds: CGRect) -> CGRect {
		let rect = super.textRect(forBounds: bounds)
		return rect.inset(by: textPadding)
	}

	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		let rect = super.editingRect(forBounds: bounds)
		return rect.inset(by: textPadding)
	}

	init() {
		super.init(frame: .zero)
		setup()
	}

	func setPlaceholder(_ string: String) {
		let attributes: [NSAttributedString.Key: Any] = [
			.font: UIFont.body ?? UIFont.systemFont(ofSize: 16),
			.foregroundColor: UIColor.white.withAlphaComponent(0.6)
		]
		attributedPlaceholder = NSAttributedString(string: string,
												   attributes: attributes)
	}

	private func setup() {
		backgroundColor = .accentGray
		font = .body
		textColor = .white
		layer.cornerRadius = 16
		layer.masksToBounds = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
