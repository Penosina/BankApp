//
//  TabBarCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 28.02.2023.
//

import Foundation

final class TabBarCoordinator: Coordinator {
	let navigationController: NavigationController
	let appDependency: AppDependency

	var childCoordinators: [Coordinator] = []
	var onDidFinish: (() -> Void)?

	init(navigationController: NavigationController, appDependency: AppDependency) {
		self.navigationController = navigationController
		self.appDependency = appDependency
	}

	func start(animated: Bool) {
		showTabBar(animated: animated)
	}

	private func showTabBar(animated: Bool) {
		let tabBarController = TabBarController()
		addPopObserver(for: tabBarController)

		let feedNavigationController = makeFeedNavigationController()
		let operationHistoryNavigationController = makeOperationHistoryNavigationController()

		let tabsInfo = [
			TabInfo(tabKind: .feed, viewController: feedNavigationController),
			TabInfo(tabKind: .history, viewController: operationHistoryNavigationController)
		]

		tabBarController.tabsInfo = tabsInfo
		navigationController.pushViewController(tabBarController, animated: animated)
	}

	private func makeFeedNavigationController() -> NavigationController {
		let navigationController = NavigationController()
		let feedCoordinator = FeedCoordinator(navigationController: navigationController,
											  appDependency: appDependency)
		childCoordinators.append(feedCoordinator)
		feedCoordinator.start(animated: false)
		return navigationController
	}

	private func makeOperationHistoryNavigationController() -> NavigationController {
		let navigationController = NavigationController()
		let operationHistoryCoordinator = FullOperationHistoryCoordinator(navigationController: navigationController,
																	  appDependency: appDependency)
		childCoordinators.append(operationHistoryCoordinator)
		operationHistoryCoordinator.start(animated: false)
		return navigationController
	}
}
