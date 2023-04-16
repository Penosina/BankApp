//
//  BankAccountViewController.swift
//  BankApp
//
//  Created by Abrosimov Ilya on 02.03.2023.
//

import UIKit

final class BankAccountViewController: UIViewController, AlertShowing {
	private let scrollView = UIScrollView()
	private let contentStackView: UIStackView = {
		let stackView = UIStackView()
		stackView.axis = .vertical
		stackView.spacing = 20
		return stackView
	}()
	private let balanceView: UIView = {
		let view = UIView()
		view.backgroundColor = .accentGray
		view.layer.cornerRadius = 16
		view.layer.masksToBounds = true
		return view
	}()
	private let balanceLabel: UILabel = {
		let label = UILabel()
		label.font = .header2
		label.textColor = .white
		label.numberOfLines = 1
		label.textAlignment = .center
		return label
	}()
	private let withdrawButton = CommonButton()
	private let replenishButton = CommonButton()
	private let makeTransferButton = CommonButton()
	private let closeAccountButton = CommonButton()
	private lazy var operationHistoryView = OperationHistoryView(viewModel: viewModel.operationHistoryViewModel)

	private let viewModel: BankAccountViewModel

	@objc
	private func withdraw() {
		viewModel.didRequestWithdraw()
	}

	@objc
	private func replenish() {
		viewModel.didRequestReplenish()
	}

	@objc
	private func makeTransfer() {
		viewModel.didRequestMakeTransfer()
	}

	@objc
	private func closeAccount() {
		let action = viewModel.didRequestCloseAccount
		showAlert(title: "Вы уверены, что хотите закрыть счет?",
				  action: action)
	}

	init(viewModel: BankAccountViewModel) {
		self.viewModel = viewModel
		super.init(nibName: nil, bundle: nil)
		setup()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		bindToViewModel()
		viewModel.start()
		operationHistoryView.configure()
	}

	private func setup() {
		title = viewModel.screenTitle

		setupScrollView()
		setupContentStackView()
		setupBalanceView()
		setupBalanceLabel()
		setupWithdrawButton()
		setupReplenishButton()
		setupMakeTransferButton()
		setupCloseAccountButton()
		setupOperationHistoryView()
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
	}

	private func setupBalanceView() {
		contentStackView.addArrangedSubview(balanceView)
		balanceView.snp.makeConstraints { make in
			make.height.equalTo(82)
		}
	}

	private func setupBalanceLabel() {
		balanceView.addSubview(balanceLabel)
		balanceLabel.snp.makeConstraints { make in
			make.edges.equalToSuperview().inset(8)
		}
		balanceLabel.text = viewModel.balance
	}

	private func setupWithdrawButton() {
		contentStackView.addArrangedSubview(withdrawButton)
		withdrawButton.setTitle("Снять", for: .normal)
		withdrawButton.addTarget(self, action: #selector(withdraw), for: .touchUpInside)
	}

	private func setupReplenishButton() {
		contentStackView.addArrangedSubview(replenishButton)
		replenishButton.setTitle("Пополнить", for: .normal)
		replenishButton.addTarget(self, action: #selector(replenish), for: .touchUpInside)
	}

	private func setupMakeTransferButton() {
		contentStackView.addArrangedSubview(makeTransferButton)
		makeTransferButton.setTitle("Сделать перевод", for: .normal)
		makeTransferButton.addTarget(self, action: #selector(makeTransfer), for: .touchUpInside)
	}

	private func setupCloseAccountButton() {
		contentStackView.addArrangedSubview(closeAccountButton)
		closeAccountButton.setTitle("Закрыть счёт", for: .normal)
		closeAccountButton.addTarget(self, action: #selector(closeAccount), for: .touchUpInside)
	}

	private func setupOperationHistoryView() {
		contentStackView.addArrangedSubview(operationHistoryView)
	}

	private func bindToViewModel() {
		viewModel.onDidLoadData = { [weak self] in
			self?.balanceLabel.text = self?.viewModel.balance
		}

		viewModel.onDidReceiveError = { [weak self] _ in
			self?.showAlert(title: "Операция не может быть выполнена!")
		}
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
