//
//  TabItemView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

protocol TabItemViewDelegate: AnyObject {
	func tabItemView(didTap tabKind: TabKind)
}

final class TabItemView: UIView {
	weak var delegate: TabItemViewDelegate?

	var isSelected = false {
		didSet {
			update()
		}
	}

	private let tabKind: TabKind
	private let stackView = UIStackView()
	private let iconImageView = UIImageView()
	private let titleLabel = UILabel()

	@objc
	private func didTap() {
		delegate?.tabItemView(didTap: tabKind)
	}

	init(tabKind: TabKind) {
	  self.tabKind = tabKind
	  super.init(frame: .zero)
	  setup()
	}

	private func setup() {
		addSubview(stackView)
		stackView.addArrangedSubview(iconImageView)
		stackView.addArrangedSubview(titleLabel)

		setupStackView()
		setupIconImageView()
		setupTitleLabel()

		addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
	}

	private func setupStackView() {
		stackView.axis = .vertical
		stackView.spacing = 4
		stackView.alignment = .center
		stackView.snp.makeConstraints { make in
			make.centerY.equalToSuperview()
			make.leading.trailing.equalToSuperview()
		}
	}

	private func setupIconImageView() {
		iconImageView.contentMode = .scaleAspectFit
		iconImageView.image = tabKind.icon?.withRenderingMode(.alwaysTemplate)
		iconImageView.snp.makeConstraints { make in
			make.size.equalTo(24)
		}
	}

	private func setupTitleLabel() {
		titleLabel.font = .footnote
		titleLabel.text = tabKind.title
		titleLabel.textColor = .white
	}

	private func update() {
		iconImageView.tintColor = isSelected ? .lightGreen : .white
		titleLabel.textColor = isSelected ? .lightGreen : .white
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
