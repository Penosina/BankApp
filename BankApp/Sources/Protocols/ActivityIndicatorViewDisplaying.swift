//
//  ActivityIndicatorViewDisplaying.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 27.02.2023.
//

import UIKit
import SnapKit

protocol ActivityIndicatorViewDisplaying {
	var activityIndicatorView: ActivityIndicatorView { get }
	var activityIndicatorContainerView: UIView { get }

	func setupActivityIndicatorView()
}

extension ActivityIndicatorViewDisplaying {
	func setupActivityIndicatorView() {
		activityIndicatorContainerView.addSubview(activityIndicatorView)
		activityIndicatorView.snp.makeConstraints { make in
			make.center.equalToSuperview()
		}
	}
}

extension ActivityIndicatorViewDisplaying where Self: UIViewController {
	var activityIndicatorContainerView: UIView {
		view
	}
}

extension ActivityIndicatorViewDisplaying where Self: UIView {
	var activityIndicatorContainerView: UIView {
		self
	}
}
