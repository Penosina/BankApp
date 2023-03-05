//
//  ImageIconView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 05.03.2023.
//

import UIKit

final class ImageIconView: UIView {
	private let imageView = UIImageView()

	var imageAsset: ImageAsset = .logout {
		didSet {
			imageView.image = UIImage(imageAsset)?.withTintColor(.white)
		}
	}

	var systemImageAsset: SystemImageAsset = .banknote {
		didSet {
			imageView.image = UIImage(systemAsset: systemImageAsset)
		}
	}

	init() {
		super.init(frame: .zero)
		setup()
	}

	private func setup() {
		backgroundColor = .accentPurple
		layer.cornerRadius = 16
		layer.masksToBounds = true
		snp.makeConstraints { make in
			make.size.equalTo(40)
		}

		setupImageView()
	}

	private func setupImageView() {
		addSubview(imageView)
		imageView.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(10)
		}
		imageView.tintColor = .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
