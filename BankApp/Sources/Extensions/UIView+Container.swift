//
//  UIView+Container.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

extension UIView {
	var inConteiner: UIView {
		let containerView = getContainerView()
		containerView.addSubview(self)
		snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(16)
		}
		return containerView
	}

	private func getContainerView() -> UIView {
		let view = UIView()
		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true
		view.backgroundColor = .accentGray
		return view
	}
}
