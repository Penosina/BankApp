//
//  OverduePaymentViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 17.04.2023.
//

import UIKit

final class OverduePaymentViewController: UIViewController {
	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let viewModel: OverduePaymentViewModel

	init(viewModel: OverduePaymentViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		bindToViewModel()
	}

	private func setup() {
		setupScrollView()
		setupContentStackView()
	}

	private func setupScrollView() {
		view.addSubview(scrollView)
		scrollView.snp.makeConstraints { make in
			make.edges.equalToSuperview()
		}
	}

	private func setupContentStackView() {
		scrollView.addSubview(contentStackView)
		contentStackView.snp.makeConstraints { make in
			make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(16)
			make.top.bottom.equalTo(scrollView.contentLayoutGuide).inset(16)
		}

		contentStackView.axis = .vertical
		contentStackView.spacing = 16
	}

	private func bindToViewModel() {

	}
}
