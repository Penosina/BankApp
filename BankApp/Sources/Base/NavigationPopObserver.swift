//
//  NavigationPopObserver.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit

final class NavigationPopObserver {
	let observedViewController: UIViewController

	private let coordinator: Coordinator

	init(observedViewController: UIViewController, coordinator: Coordinator) {
		self.observedViewController = observedViewController
		self.coordinator = coordinator
	}

	func didObservePop() {
		coordinator.onDidFinish?()
	}
}
