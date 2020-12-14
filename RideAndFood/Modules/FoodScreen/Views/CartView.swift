//
//  CartView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CartView: UIView {
    
    // MARK: - UI
    
    weak var delegate: FoodViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = ColorHelper.primaryText.color()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var shopNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = FontHelper.regular15.font()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.primaryText.color()
        label.text = FoodStrings.cart.text()
        label.font = FontHelper.semibold26.font()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emptyCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(emptyCartTapped), for: .touchUpInside)
        button.setImage(UIImage(named: "Trash"), for: .normal)
        button.tintColor = ColorHelper.primaryText.color()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CartRowCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var deliveryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deliveryCostLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = FontHelper.regular15.font()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deliveryView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.controlBackground.color()
        view.addSubview(deliveryLabel)
        view.addSubview(deliveryCostLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            CartButton(icon: UIImage(named: "promo"),
                       title: PromoCodesStrings.title.text(),
                       target: self,
                       action: #selector(promoButtonTapped)),
            CartButton(icon: UIImage(named: "points"),
                       title: PaymentStrings.points.text(),
                       target: self,
                       action: #selector(pointsButtonTapped))
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var goToPaymentButton: PrimaryButton = {
        let button = PrimaryButton()
        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dimmerView: UIView = {
        let view = UIView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(hideCardView)))
        view.backgroundColor = ColorHelper.transparentGray.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? bottomAnchor,
                                                                                 constant: hideCardViewConstant)
    
    private let hideCardViewConstant: CGFloat = 1000
    private let padding: CGFloat = 25
    private let cellHeight: CGFloat = 60
    
    // MARK: - Private properties
    
    private let cellReuseIdentifier = "cartRowCell"
    private var cartRows: [CartRowModel] = []
    private var backButtonTappedBlock: (() -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        let topStackView = UIStackView(arrangedSubviews: [
            backButton,
            shopNameLabel,
            emptyCartButton
        ])
        topStackView.distribution = .equalSpacing
        topStackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(topStackView)
        addSubview(titleLabel)
        addSubview(tableView)
        addSubview(deliveryView)
        addSubview(buttonsStackView)
        addSubview(goToPaymentButton)
        
        NSLayoutConstraint.activate([
            topStackView.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: padding),
            topStackView.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            topStackView.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                  constant: padding),
            titleLabel.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 17),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                   constant: -padding),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: cellHeight * 3),
            deliveryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            deliveryView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: padding),
            deliveryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            deliveryLabel.leadingAnchor.constraint(equalTo: deliveryView.leadingAnchor, constant: padding),
            deliveryLabel.topAnchor.constraint(equalTo: deliveryView.topAnchor, constant: 12),
            deliveryLabel.bottomAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: -12),
            deliveryCostLabel.trailingAnchor.constraint(equalTo: deliveryView.trailingAnchor, constant: -padding),
            deliveryCostLabel.centerYAnchor.constraint(equalTo: deliveryView.centerYAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            buttonsStackView.topAnchor.constraint(equalTo: deliveryView.bottomAnchor, constant: padding),
            buttonsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            goToPaymentButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            goToPaymentButton.topAnchor.constraint(greaterThanOrEqualTo: buttonsStackView.bottomAnchor, constant: padding),
            goToPaymentButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            goToPaymentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding / 2)
        ])
    }
    
    private func showCardView() {
        cardViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.dimmerView.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    @objc private func hideCardView() {
        cardViewBottomConstraint.constant = hideCardViewConstant
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmerView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.dimmerView.removeFromSuperview()
            self.cardView.removeFromSuperview()
        }
    }
    
    private func showCartIsEmptyViews() {
        let emptyCartView = EmptyCartView()
        emptyCartView.alpha = 0
        emptyCartView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(emptyCartView)
        NSLayoutConstraint.activate([
            emptyCartView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            emptyCartView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            emptyCartView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
	        hideCardView()
        UIView.animate(withDuration: 0.2) {
            emptyCartView.alpha = 1
        }
    }
    
    private func emptyCart() {
        UIView.animate(withDuration: 0.2) {
            [self.emptyCartButton,
             self.shopNameLabel,
             self.titleLabel,
             self.tableView,
             self.deliveryView,
             self.buttonsStackView,
             self.goToPaymentButton].forEach { $0.alpha = 0 }
        } completion: { _ in
            self.showCartIsEmptyViews()
        }
    }
    
    @objc private func backButtonTapped() {
        backButtonTappedBlock?()
    }
    
    @objc private func emptyCartTapped() {
        let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
        if cardView.superview == nil {
            if let view = window {
                addSubview(dimmerView)
                NSLayoutConstraint.activate([
                    dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    dimmerView.topAnchor.constraint(equalTo: view.topAnchor),
                    dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                    dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
            }
            addSubview(cardView)
            
            NSLayoutConstraint.activate([
                cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
                cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
                cardViewBottomConstraint
            ])
            layoutIfNeeded()
        }
        
        let confirmationView = TitledButtonsStackView()
        confirmationView.configure(with: .init(buttonsStackViewModel: .init(primaryTitle: FoodStrings.empty.text(),
                                                                            secondaryTitle: StringsHelper.cancel.text(),
                                                                            primaryButtonPressedBlock: { [weak self] in
                                                                                CartModel.shared.emptyCart()
                                                                                self?.emptyCart()
                                                                            },
                                                                            secondaryButtonPressedBlock: { [weak self] in
                                                                                self?.hideCardView()
                                                                            }),
                                               titleColor: ColorHelper.error.color(),
                                               title: FoodStrings.emptyCart.text()))
        cardView.configure(with: .init(contentView: confirmationView,
                                       style: .light,
                                       paddingBottom: (window?.safeAreaInsets.bottom ?? 0) + 5,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.hideCardView()
                                       }))
        showCardView()
    }
    
    @objc private func promoButtonTapped() {
        
    }
    
    @objc private func pointsButtonTapped() {
        
    }
    
    @objc private func paymentButtonTapped() {
        
    }
    
    @objc private func dimmerTapped() {
        hideCardView()
    }
}

// MARK: - ConfigurableView

extension CartView: IConfigurableView {
    func configure(with model: CartViewModel) {
        cartRows = model.cartRows
        tableView.reloadData()
        let deliverWithin = FoodStrings.deliverWithin.text()
        let deliveryTime = "≈\(model.deliveryTimeInMinutes) \(StringsHelper.minutes.text())"
        let deliveryString = NSMutableAttributedString(string: "\(deliverWithin) \(deliveryTime)")
        deliveryString.addAttributes([.foregroundColor: ColorHelper.notification.color() as Any,
                                      .font: FontHelper.semibold17.font() as Any],
                                     range: .init(location: deliverWithin.count + 1,
                                                  length: deliveryTime.count))
        deliveryLabel.attributedText = deliveryString
        deliveryCostLabel.text = model.deliveryCost.currencyString()
        goToPaymentButton.setTitles(left: FoodStrings.goToPayment.text(), right: model.sum.currencyString())
        shopNameLabel.text = model.shopName
        backButtonTappedBlock = model.backButtonTappedBlock
    }
}

extension CartView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

extension CartView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as? CartRowCell
        else { return UITableViewCell() }
        
        cell.configure(with: .init(model: cartRows[indexPath.row]))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
