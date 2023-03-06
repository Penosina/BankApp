//
//  LoanViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 06.03.2023.
//

import UIKit

final class LoanViewController: UIViewController {
	private let scrollView = UIScrollView()
	private let contentStackView = UIStackView()
	private let amountLabel = TwoLabel()
	private let debtLabel = TwoLabel()
	private let rateLabel = TwoLabel()
	private let periodLabel = TwoLabel()
	private let repayButton = CommonButton()

	private let viewModel: LoanViewModel

	@objc
	private func repay() {
		viewModel.repay()
	}

	init(viewModel: LoanViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindToViewModel()
	}

	private func setup() {
		title = viewModel.title

		setupScrollView()
		setupContentStackView()
		setupAmountLabel()
		setupDebtLabel()
		setupRateLabel()
		setupPeriodLabel()
		setupRepayButton()
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
			make.leading.trailing.equalTo(scrollView.frameLayoutGuide).inset(20)
			make.top.bottom.equalTo(scrollView.contentLayoutGuide).inset(20)
		}

		contentStackView.axis = .vertical
		contentStackView.spacing = 20
	}

	private func setupAmountLabel() {
		contentStackView.addArrangedSubview(amountLabel.inConteiner)
		amountLabel.title = "СУММА КРЕДИТА"
		amountLabel.subtitle = viewModel.amount
	}

	private func setupDebtLabel() {
		contentStackView.addArrangedSubview(debtLabel.inConteiner)
		debtLabel.title = "ОСТАЛОСЬ ОПЛАТИТЬ"
		debtLabel.subtitle = viewModel.debt
	}

	private func setupRateLabel() {
		contentStackView.addArrangedSubview(rateLabel.inConteiner)
		rateLabel.title = "ВЗЯТО ПОД"
		rateLabel.subtitle = viewModel.rate
	}

	private func setupPeriodLabel() {
		contentStackView.addArrangedSubview(periodLabel.inConteiner)
		periodLabel.title = "СРОК КРЕДИТОВАНИЯ"
		periodLabel.subtitle = viewModel.period
	}

	private func setupRepayButton() {
		contentStackView.addArrangedSubview(repayButton)
		repayButton.setTitle("Внести платеж", for: .normal)
		repayButton.addTarget(self, action: #selector(repay), for: .touchUpInside)
	}

	private func bindToViewModel() {
		viewModel.onDidUpdateData = { [weak self] in
			self?.amountLabel.subtitle = self?.viewModel.amount
			self?.debtLabel.subtitle = self?.viewModel.debt
			self?.rateLabel.subtitle = self?.viewModel.rate
			self?.periodLabel.subtitle = self?.viewModel.period
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
