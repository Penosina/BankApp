//
//  AlertShowing.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

protocol AlertShowing: AnyObject {
	func showAlert(title: String, description: String?, action: (() -> Void)?)
}

extension AlertShowing where Self: UIViewController {
	func showAlert(title: String, description: String? = nil, action: (() -> Void)? = nil) {
		let alertController = UIAlertController(title: title,
												message: description,
												preferredStyle: .alert)
		if let action = action {
			let cancelAction = UIAlertAction(title: "Отменить", style: .cancel)
			let okAction = UIAlertAction(title: "Закрыть", style: .destructive) { _ in
				action()
			}
			alertController.addAction(okAction)
			alertController.addAction(cancelAction)
		} else {
			let cancelAction = UIAlertAction(title: "Ок", style: .cancel)
			alertController.addAction(cancelAction)
		}
		present(alertController, animated: true)
	}
}
