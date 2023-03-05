//
//  SceneDelegate.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	private var mainCoordinator: MainCoordinator?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }

		window = UIWindow(windowScene: scene)
		let navigationController = NavigationController()
		window?.rootViewController = navigationController
		window?.makeKeyAndVisible()

		mainCoordinator = MainCoordinator(navigationController: navigationController)
		mainCoordinator?.start(animated: false)
	}
}
