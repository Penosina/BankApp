//
//  ActivityIndicatorView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 03.03.2023.
//

import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {
	init() {
		super.init(frame: .zero)
		setup()
	}

	override func startAnimating() {
		isHidden = false
		super.startAnimating()
	}

	private func setup() {
		isHidden = true
		hidesWhenStopped = true
	}

	required init(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
