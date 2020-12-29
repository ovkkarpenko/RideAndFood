//
//  CartView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

protocol CartViewDelegate: class {
    func foodPaymentButtonTapped(amount: String)
}

class CartView: UIView {
    
    // MARK: - UI
    
    weak var delegate: FoodViewDelegate?
    weak var cartViewDelegate: CartViewDelegate?
    
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
    
    private lazy var promoCodeButton: CartButton = {
        var promoImageView = UIImageView(image: UIImage(named: "promo"))
        promoImageView.contentMode = .scaleAspectFit
        return CartButton(icon: promoImageView,
                          title: PromoCodesStrings.title.text(),
                          target: self,
                          action: #selector(promoButtonTapped))
    }()
    
//    private lazy var pointsButton: CartButton = {
//        var pointsImageView = UIImageView(image: UIImage(named: "points"))
//        pointsImageView.contentMode = .scaleAspectFit
//        return CartButton(icon: pointsImageView,
//                          title: PaymentStrings.points.text(),
//                          target: self,
//                          action: #selector(pointsButtonTapped))
//    }()
    
    private lazy var pointsButton: UIButton = {
        let view = UIButton(type: .system)
        view.contentEdgeInsets = UIEdgeInsets(top: 0, left: -50, bottom: 0, right: 10)
        view.setTitle(PaymentStrings.points.text(), for: .normal)
        view.setImage(UIImage(named: "points"), for: .normal)
        view.setTitleColor(Colors.textBlack.getColor(), for: .normal)
        view.tintColor = Colors.yellow.getColor()
        view.layer.cornerRadius = generalCornerRaduis
        view.layer.shadowOpacity = 0.1
        view.backgroundColor = ColorHelper.background.color()
        view.addTarget(self, action: #selector(pointsButtonTapped), for: .touchUpInside)
        view.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return view
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            promoCodeButton,
            pointsButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
//    private lazy var goToPaymentButton: PrimaryButton = {
//        let button = PrimaryButton()
//        button.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private lazy var goToPaymentButton: ComplexButton = {
        let view = ComplexButton()
        view.actionButton.addTarget(self, action: #selector(paymentButtonTapped), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var dimmerView: DimmerView = {
        let view = DimmerView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                         action: #selector(dimmerTapped)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: superview?.bottomAnchor ?? bottomAnchor,
                                                                                 constant: hideCardViewConstant)
    
    private var pointsCount: Int?
    
    private let hideCardViewConstant: CGFloat = 1000
    private let padding: CGFloat = 25
    private let cellHeight: CGFloat = 60
    
    // MARK: - Private properties
    
    private let cellReuseIdentifier = "cartRowCell"
    private var cartRows: [CartRowModel] = []
    private var backButtonTappedBlock: (() -> Void)?
    private lazy var promoCodesInteractor = PromoCodesInteractor()
    private var sum: Float = 0
    private var sumWithDiscount: Float = 0
    private var promoCodeDiscount: Int = 0 {
        didSet {
            updateSum()
        }
    }
    private var pointsDiscount: Int = 0 {
        didSet {
            updateSum()
        }
    }
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupNotifications()
        setupLayout()
        checkPromocodes()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupNotifications()
        setupLayout()
        checkPromocodes()
    }
    
    // MARK: - Private methods
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
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
            goToPaymentButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding / 2),
            goToPaymentButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func showCardView() {
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
        cardViewBottomConstraint.constant = 0
        UIView.animate(withDuration: 0.2) {
            self.dimmerView.alpha = 1
            self.layoutIfNeeded()
        }
    }
    
    private func hideCardView(completion: (() -> Void)? = nil) {
        cardViewBottomConstraint.constant = hideCardViewConstant
        UIView.animate(withDuration: 0.2, animations: {
            self.dimmerView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            self.dimmerView.removeFromSuperview()
            self.cardView.removeFromSuperview()
            completion?()
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
    
    private func showPromoCodeActivatedView(descriptionText: String?) {
        let view = PromoCodeActivatedView()
        view.descriptionText = descriptionText
        let padding: CGFloat = 35
        cardView.configure(with: .init(contentView: view,
                                       style: .light,
                                       paddingTop: padding,
                                       paddingBottom: padding,
                                       paddingX: padding / 2,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.hideCardView()
                                       }))
        showCardView()
    }
    
    private func checkPromocodes() {
        promoCodesInteractor.getPromoCodes() { [weak self] (promoCodes, errorText) in
            guard let promoCodes = promoCodes, errorText == nil else { return }
            let promoCode = promoCodes
                .map { PromoCodeCellModel(promoCode: $0) }
                .filter { $0.isActive && $0.title.contains("Еда") }
                .sorted { $0.expireDate > $1.expireDate }
                .first
            if let code = promoCode {
                DispatchQueue.main.async {
                    self?.promoCodeButton.disable()
                    self?.promoCodeButton.setLeftLabel(text: code.saleText)
                    self?.promoCodeDiscount = code.sale
                }
            }
        }
    }
    
    private func updateSum() {
        guard promoCodeDiscount > 0 || pointsDiscount > 0 else { return }
        sumWithDiscount -= sum / 100 * Float(promoCodeDiscount)
        sumWithDiscount -= Float(pointsDiscount)
//        goToPaymentButton.setTitles(left: FoodStrings.goToPayment.text(),
//                                    right: "\(sum.currencyString()) \(sumWithDiscount.currencyString())")
        goToPaymentButton.setPreviousCost(cost: sum.currencyString())
        sumWithDiscount = sumWithDiscount < 0 ? 0 : sumWithDiscount
        goToPaymentButton.setNewCost(text: sumWithDiscount.currencyString())
    }
    
    private func updatePointsButton() {
        if Float(pointsDiscount) > sum {
            pointsDiscount = Int(sum)
        }
        
        let title = NSMutableAttributedString(string: "-\(pointsDiscount) ", attributes: [NSAttributedString.Key.foregroundColor : Colors.buttonGreen.getColor()])
        title.append(NSAttributedString(string: FoodStrings.points.text(), attributes: [NSAttributedString.Key.foregroundColor : Colors.textGray.getColor()]))
        pointsButton.setAttributedTitle(title, for: .normal)
        pointsButton.backgroundColor = Colors.backgroundGray.getColor()
        pointsButton.layer.shadowOpacity = 0
        pointsButton.setImage(nil, for: .normal)
        pointsButton.isEnabled = false
    }
    
    @objc private func backButtonTapped() {
        backButtonTappedBlock?()
    }
    
    @objc private func emptyCartTapped() {
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
        let contentView = EnterPromoCodeView()
        contentView.confirmBlock = { [weak self] code in
            self?.promoCodesInteractor.activatePromoCode(code: code) { (result, errorText) in
                guard let result = result, errorText == nil else {
                    DispatchQueue.main.async {
                        contentView.errorText = errorText
                    }
                    return
                }
                self?.checkPromocodes()
                DispatchQueue.main.async {
                    self?.hideCardView(completion: {
                        self?.showPromoCodeActivatedView(descriptionText: result.description)
                    })
                }
            }
        }
        cardView.configure(with: .init(contentView: contentView,
                                       style: .light,
                                       paddingTop: 0,
                                       paddingBottom: (window?.safeAreaInsets.bottom ?? 0) + 5,
                                       paddingX: 0,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.hideCardView()
                                       }))
        showCardView()
        contentView.focusTextView()
    }
    
    @objc private func pointsButtonTapped() {
        let viewModel = SelectTariffViewModel()
        viewModel.getPointsCount { [weak self] credits in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if credits > 0 {
                    self.pointsCount = credits
                    let pointsView = PointsView(frame: CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.frame.width, height: self.frame.height + self.padding / 2))
                    pointsView.delegate = self
                    pointsView.pointsCount = credits
                    self.addSubview(pointsView)
                }
            }
        }
    }
    
    @objc private func paymentButtonTapped() {
        if sumWithDiscount.currencyString().isEmpty {
            cartViewDelegate?.foodPaymentButtonTapped(amount: sum.currencyString())
        } else {
            cartViewDelegate?.foodPaymentButtonTapped(amount: sumWithDiscount.currencyString())
        }
    }
    
    @objc private func dimmerTapped() {
        hideCardView()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            cardViewBottomConstraint.constant = -keyboardSize.height
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        cardViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.layoutIfNeeded()
        }
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
//        goToPaymentButton.setTitles(left: FoodStrings.goToPayment.text(), right: model.sum.currencyString())
        goToPaymentButton.setNewCost(text: model.sum.currencyString())
        shopNameLabel.text = model.shopName
        backButtonTappedBlock = model.backButtonTappedBlock
        sum = model.sum
        sumWithDiscount = model.sum
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

extension CartView: PointsViewDelegate {
    func spendAllPoints() {
        pointsDiscount = pointsCount!
        if pointsDiscount > 0 {
            updatePointsButton()
        }
    }
    
    func setPointsToSpend(points: String) {
        pointsDiscount = Int(points) ?? 0
        // should update points count in server
        if pointsDiscount > 0 {
            updatePointsButton()
        }
    }
}
