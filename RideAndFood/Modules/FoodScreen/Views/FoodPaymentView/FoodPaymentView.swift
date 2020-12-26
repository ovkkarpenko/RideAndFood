//
//  FoodPaymentView.swift
//  RideAndFood
//
//  Created by Laura Esaian on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class FoodPaymentView: CustomViewWithAnimation {
    private let padding: CGFloat = 25
    
    private var changeCount: Int = 0
    
    private var paymentType: PaymentType = UserConfig.shared.paymentType
    
    private var totalAmount: String = "0"
    
    var dismissFoodPaymentView: (() -> ())?
    
    private lazy var foodPaymentModel: FoodPaymentModel = {
        let model = FoodPaymentModel { [weak self] in
            self?.tableView.reloadData()
        }
        
        return model
    }()
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [tableView, needChangeStackView, payButton])
        view.axis = .vertical
        view.spacing = padding
        view.alignment = .center
        view.distribution = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var needChangeStackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [needChangeButton, needChangeIndicatorView])
        view.axis = .vertical
        view.spacing = padding / 5
        view.alignment = .leading
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.tableFooterView = UIView()
        view.isScrollEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tapIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        view.backgroundColor = Colors.getColor(.tapIndicatorOnDark)()
        return view
    }()
    
    private lazy var title: UILabel = {
        let view = UILabel()
        view.text = "Оформление заказа"
        view.textColor = Colors.textGray.getColor()
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let view = UIButton(type: .system)
        view.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        view.tintColor = Colors.textBlack.getColor()
        view.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var needChangeButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(FoodStrings.needChange.text(), for: .normal)
        view.setTitleColor(Colors.textGray.getColor(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addTarget(self, action: #selector(needChangeButtonTapped), for: .touchUpInside)
        
        return view
    }()
    
    private lazy var needChangeIndicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.tableViewBorderGray.getColor()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var payButton: ComplexButton = {
        let view = ComplexButton()
        view.setNewCost(text: "\(totalAmount)")
        view.actionButton.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tableViewBottomConstraintWhileCashPaymentSelected = tableView.bottomAnchor.constraint(equalTo: needChangeButton.topAnchor, constant: -padding)
    private lazy var tableViewBottomConstraintWhileCashPaymentDselected = tableView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -padding)
    
    init(amount: String) {
        self.totalAmount = amount
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 530))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        tableView.delegate = self
        tableView.dataSource = self
        
        setupLayout()
    }
    
    // MARK: - private methods
    private func setupLayout() {
        backgroundColor = UIColor.white
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = generalCornerRaduis
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissAndRemoveFromSuperView))
        swipeGesture.direction = .down
        addGestureRecognizer(swipeGesture)
        
        addSubview(tapIndicator)
        addSubview(title)
        addSubview(backButton)
        addSubview(stackView)
        
        NSLayoutConstraint.activate([tapIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     tapIndicator.bottomAnchor.constraint(equalTo: topAnchor, constant: -padding / 2),
                                     tapIndicator.heightAnchor.constraint(equalToConstant: 5),
                                     tapIndicator.widthAnchor.constraint(equalToConstant: 40),
                                     title.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                                     title.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     backButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
                                     backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                     backButton.widthAnchor.constraint(equalToConstant: 13),
                                     backButton.trailingAnchor.constraint(greaterThanOrEqualTo: title.leadingAnchor, constant: padding / 2),
                                     needChangeStackView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                                     needChangeStackView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                                     needChangeStackView.heightAnchor.constraint(equalToConstant: 20),
                                     needChangeButton.leadingAnchor.constraint(equalTo: needChangeStackView.leadingAnchor),
                                     needChangeIndicatorView.leadingAnchor.constraint(equalTo: needChangeStackView.leadingAnchor),
                                     needChangeIndicatorView.trailingAnchor.constraint(equalTo: needChangeStackView.trailingAnchor),
                                     needChangeIndicatorView.heightAnchor.constraint(equalToConstant: 1),
                                     stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                     stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                                     stackView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding),
                                     tableView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                                     payButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                                     payButton.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                                     payButton.heightAnchor.constraint(equalToConstant: 50),
                                     stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)])

        hideNeedChangeView()
        setButtonText()
    }
    
    private func setButtonText() {
        if paymentType == .cash {
            payButton.setLeftLabelText(text: FoodStrings.order.text())
        } else {
            payButton.setLeftLabelText(text: FoodStrings.pay.text())
        }
    }
    
    private func hideNeedChangeView() {
        changeCount = 0
        needChangeButton.setAttributedTitle(NSAttributedString(string: FoodStrings.needChange.text()), for: .normal)
        needChangeStackView.isHidden = true
    }
    
    private func showNeedChangeView() {
        needChangeStackView.isHidden = false
    }
    
    @objc private func dismissAndRemoveFromSuperView() {
        dismissFoodPaymentView?()
    }
    
    @objc private func backButtonTapped() {
        dismissAndRemoveFromSuperView()
    }
    
    @objc private func payButtonTapped() {
    }
    
    @objc private func needChangeButtonTapped() {
        let changeCountView = ChangeCountView(frame: CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        changeCountView.delegate = self
        UIApplication.shared.windows[0].rootViewController?.view.addSubview(changeCountView)
    }
}

// MARK: - extensions
extension FoodPaymentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return foodPaymentModel.deliveryAddressCell.count
        } else {
            return foodPaymentModel.foodPaymentCell.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 43.5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return foodPaymentModel.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = AddressCell()
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            cell.firstLabel.text = foodPaymentModel.deliveryAddressCell[indexPath.row].addressName
            cell.secondLabel.text = foodPaymentModel.deliveryAddressCell[indexPath.row].address
            tableView.register(AddressCell.self, forCellReuseIdentifier: AddressCell.ADDRESS_CELL)
            
            return cell
        } else {
            let cell = PaymentTypeCell()
            if paymentType == foodPaymentModel.foodPaymentCell[indexPath.row].type {
                cell.checkButton.isSelected = true
                if paymentType == .cash {
                    showNeedChangeView()
                }
            }
            cell.cellTextLabel.attributedText = foodPaymentModel.foodPaymentCell[indexPath.row].text
            cell.icon.image = foodPaymentModel.foodPaymentCell[indexPath.row].image
            tableView.register(PaymentTypeCell.self, forCellReuseIdentifier: PaymentTypeCell.PAYMENT_TYPE_CELL)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        header.font = UIFont.boldSystemFont(ofSize: 15)
        
        if section == 0 {
            header.text = foodPaymentModel.deliveryCellTitle
        } else {
            header.text = foodPaymentModel.paymentCellTitle
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentTypeCell {
            deselectAllRows()
            cell.checkButton.isSelected = true
            
            paymentType = foodPaymentModel.foodPaymentCell[indexPath.row].type

            if paymentType == .cash {
                showNeedChangeView()
            } else {
                hideNeedChangeView()
            }
            
            setButtonText()

            UIView.animate(withDuration: generalAnimationDuration) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    private func deselectAllRows() {
        for section in 0..<tableView.numberOfSections {
            for row in 0..<tableView.numberOfRows(inSection: section) {
                if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) as? PaymentTypeCell {
                    cell.checkButton.isSelected = false
                }
            }
        }
    }

    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentTypeCell {
            cell.checkButton.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
}

extension FoodPaymentView: ChangeCountViewDelegate {
    func changeCountSelected(count: Int) {
        needChangeButton.setAttributedTitle(createAttributedTitle(text: "\(count)"), for: .normal)
        changeCount = count
    }
    
    private func createAttributedTitle(text: String) -> NSAttributedString {
        let attriburedText = NSMutableAttributedString(string: FoodStrings.needChange.text(), attributes: [NSAttributedString.Key.foregroundColor : Colors.textGray.getColor()])
        attriburedText.append(NSAttributedString(string: " \(FoodStrings.from.text()) \(text) \(OrdersHistoryStrings.rub.text())", attributes: [NSAttributedString.Key.foregroundColor : Colors.textBlack.getColor()]))
        
        return attriburedText
    }
}
