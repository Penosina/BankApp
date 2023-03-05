//
//  TabBarView.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

protocol TabBarViewDelegate: AnyObject {
	func tabBarView(didSelectTab tabKind: TabKind)
}

final class TabBarView: UIView {
	weak var delegate: TabBarViewDelegate?

	var selectedIndex: Int = 0 {
		didSet {
			update()
		}
	}

	private var tabItemViews: [TabItemView] = []

	private let tabItemsStackView = UIStackView()

	init() {
		super.init(frame: .zero)
		setup()
	}

	func configure(with tabKinds: [TabKind]) {
		tabItemsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
		tabKinds.forEach { tabKind in
			let itemView = TabItemView(tabKind: tabKind)
			itemView.delegate = self
			tabItemViews.append(itemView)
		}

		tabItemViews.forEach { tabItemsStackView.addArrangedSubview($0) }
		update()
	}

	private func setup() {
		backgroundColor = .accentGray
		setupTabItemsStackView()

		layer.cornerRadius = 16
		layer.masksToBounds = true
	}

	private func setupTabItemsStackView() {
		addSubview(tabItemsStackView)

		tabItemsStackView.distribution = .fillEqually
		tabItemsStackView.snp.makeConstraints { make in
			make.top.equalToSuperview().inset(16)
			make.leading.trailing.equalToSuperview()
			make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
			make.height.equalTo(36)
		}
	}

	private func update() {
		guard selectedIndex < tabItemViews.count else { return }
		tabItemViews.forEach { $0.isSelected = false }
		tabItemViews[selectedIndex].isSelected = true
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

extension TabBarView: TabItemViewDelegate {
	func tabItemView(didTap tabKind: TabKind) {
		delegate?.tabBarView(didSelectTab: tabKind)
	}
}
