//
//  ConfigurableCoordinator.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 04.03.2023.
//

import Foundation

protocol ConfigurableCoordinator: Coordinator {
	associatedtype Configuration

	init(navigationController: NavigationController,
		 appDependency: AppDependency,
		 configuration: Configuration)
}

extension ConfigurableCoordinator {
	init(navigationController: NavigationController, appDependency: AppDependency) {
		fatalError("Use init with configuration for this coordinator")
	}
}
