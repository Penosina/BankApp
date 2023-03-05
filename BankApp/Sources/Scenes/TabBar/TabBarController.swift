//
//  TabBarController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import UIKit

struct TabInfo {
	let tabKind: TabKind
	let viewController: UIViewController
}

final class TabBarController: UITabBarController, NavigationBarHiding {
	var tabsInfo: [TabInfo] = [] {
		didSet {
			update()
		}
	}

	override var selectedIndex: Int {
		didSet {
			tabBarView.selectedIndex = selectedIndex
		}
	}

	private let tabBarView = TabBarView()

	override func viewDidLoad() {
		super.viewDidLoad()
		setup()
	}

	private func setup() {
		setupTabBar()
	}

	private func setupTabBar() {
		view.addSubview(tabBarView)
		tabBarView.snp.makeConstraints { make in
			make.leading.trailing.bottom.equalToSuperview().inset(24)
		}

		tabBarView.delegate = self

		tabBar.alpha = 0
		tabBar.layer.zPosition = -1
		tabBar.isUserInteractionEnabled = false
	}

	private func update() {
		viewControllers = tabsInfo.map(\.viewController)
		tabBarView.configure(with: tabsInfo.map(\.tabKind))
	}
}

extension TabBarController: TabBarViewDelegate {
	func tabBarView(didSelectTab tabKind: TabKind) {
		guard let index = tabsInfo.firstIndex(where: { $0.tabKind == tabKind }) else { return }
		selectedIndex = index
	}
}
