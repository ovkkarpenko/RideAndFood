//
//  FoodPaymentView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class FoodPaymentView: CustomViewWithAnimation {
    private let padding: CGFloat = 25
    
    private var tableView: UITableView = {
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
//        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: -180, bottom: 0, right: 0)
        view.setTitle(FoodStrings.needChange.text(), for: .normal)
        view.setTitleColor(Colors.textGray.getColor(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
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
        view.setNewCost(text: "231")
        view.setLeftLabelText(text: "Pay")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var tableViewBottomConstraintWhileCashPaymentSelected = tableView.bottomAnchor.constraint(equalTo: needChangeButton.topAnchor, constant: -padding)
    private lazy var tableViewBottomConstraintWhileCashPaymentDselected = tableView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -padding)
    
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
        
        addSubview(title)
        addSubview(backButton)
        addSubview(tableView)
        addSubview(tapIndicator)
        addSubview(needChangeButton)
        addSubview(needChangeIndicatorView)
        addSubview(payButton)
        
        NSLayoutConstraint.activate([title.topAnchor.constraint(equalTo: topAnchor, constant: padding),
                                     title.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     backButton.centerYAnchor.constraint(equalTo: title.centerYAnchor),
                                     backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                     backButton.widthAnchor.constraint(equalToConstant: 13),
                                     backButton.trailingAnchor.constraint(greaterThanOrEqualTo: title.leadingAnchor, constant: padding / 2),
                                     tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: padding),
                                     tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: padding),
                                     tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -padding),
//                                     tableViewBottomConstraintWhileCashPaymentDselected,
                                     tapIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                     tapIndicator.bottomAnchor.constraint(equalTo: topAnchor, constant: -padding / 2),
                                     tapIndicator.heightAnchor.constraint(equalToConstant: 5),
                                     tapIndicator.widthAnchor.constraint(equalToConstant: 40),
                                     payButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                     payButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                                     payButton.heightAnchor.constraint(equalToConstant: 50),
                                     payButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
                                     needChangeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
//                                     needChangeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                                     needChangeButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: padding),
                                     needChangeButton.bottomAnchor.constraint(equalTo: needChangeIndicatorView.topAnchor, constant: -padding / 4),
                                     needChangeIndicatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
                                     needChangeIndicatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
                                     needChangeIndicatorView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -padding),
                                     needChangeIndicatorView.heightAnchor.constraint(equalToConstant: 1)])
        
        hideNeedChangeView()
        
    }
    
    private func hideNeedChangeView() {
        needChangeButton.isHidden = true
        needChangeIndicatorView.isHidden = true
    }
    
    private func showNeedChangeView() {
        needChangeButton.isHidden = false
        needChangeIndicatorView.isHidden = false
    }
    
    @objc private func backButtonTapped() {
    }
}

// MARK: - extensions
extension FoodPaymentView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = Bundle.main.loadNibNamed("AddressCell", owner: self, options: nil)![0] as! UITableViewCell
            cell.selectionStyle = .none
            cell.isUserInteractionEnabled = false
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AddressCell")
            
            return cell
        } else {
            let cell = PaymentTypeCell()
            cell.cellTextLabel.text = "fsdfdsfds"
            cell.icon.image = UIImage(named: "applePay")
            tableView.register(PaymentTypeCell.self, forCellReuseIdentifier: PaymentTypeCell.PAYMENT_TYPE_CELL)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UILabel()
        tableView.sectionHeaderHeight = 30
        
        if section == 0 {
            header.text = "Адрес доставки"
        } else {
            header.text = "Способ оплаты"
        }
        
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentTypeCell {
            cell.checkButton.isSelected = true
            if indexPath.row == 0 {
                showNeedChangeView()
            } else {
                hideNeedChangeView()
            }
            
            UIView.animate(withDuration: generalAnimationDuration) { [weak self] in
                self?.layoutIfNeeded()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? PaymentTypeCell {
            cell.checkButton.isSelected = false
        }
    }
}
