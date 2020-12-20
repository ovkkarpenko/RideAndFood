//
//  FoodView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 17.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

enum SelectedViewType {
    case address
    case shop
    case shopCategory
    case shopDetails
    case shopProducts
    case productCategory
    case cardView
}

protocol FoodViewDelegate: class {
    func shopMap()
    func showShop(address: Address?)
    func showShopCategory(shop: FoodShop?)
    func showShopDetails()
    func showShopProducts(shopId: Int?, subCategory: ShopSubCategory?)
    func showProductCategory(category: ShopCategory?)
    func showProductDetails(_ shopProduct: ShopProduct?)
    func showCartView()
}

class FoodView: UIView {
    
    var currentUserAddress: String?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodAddressView: FoodAddressView = {
        let view = FoodAddressView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodShopView: FoodShopView = {
        let view = FoodShopView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shopCategoryView: ShopCategoryView = {
        let view = ShopCategoryView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shopSubCategoryView: ShopSubCategoryView = {
        let view = ShopSubCategoryView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shopDetailsView: ShopDetailsView = {
        let view = ShopDetailsView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shopProductsView: ShopProductsView = {
        let view = ShopProductsView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var productDetailsView = ProductDetailsView()
    
    private lazy var cartView = CartView()
    
    private lazy var cardView: CardView = {
        let cardView = CardView()
        cardView.translatesAutoresizingMaskIntoConstraints = false
        return cardView
    }()
    
    private var selectedShop: FoodShop?
    private var currentShopId: Int?
    
    private lazy var dimmerView: DimmerView = {
        let view = DimmerView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        CartModel.shared.observers.append(self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        CartModel.shared.observers.append(self)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == backgroundView {
            toggle(true, view: foodAddressView, constraint: foodAddressViewHeightConstraint, dismiss: selectedView == .address)
            toggle(true, view: foodShopView, constraint: foodShopViewHeightConstraint, dismiss: selectedView == .shop)
            toggle(true, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint, dismiss: selectedView == .shopCategory)
            toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint, dismiss: selectedView == .productCategory)
            toggle(true, view: shopDetailsView, constraint: shopDetailsViewHeightConstraint, dismiss: selectedView == .shopDetails)
            toggle(true, view: shopProductsView, constraint: shopProductsViewHeightConstraint, dismiss: selectedView == .shopProducts)
            toggle(true, view: cardView, constraint: cardViewBottomConstraint, dismiss: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLoaded {
            isLoaded = true
            foodAddressView.addressTextField.text = currentUserAddress ?? ""
            toggle(false, view: foodAddressView, constraint: foodAddressViewHeightConstraint)
        }
    }
    
    private var isLoaded: Bool = false
    private var selectedView: SelectedViewType = .address
    private var previousSelectedView: SelectedViewType = .address
    
    private let padding: CGFloat = 20
    
    private lazy var foodAddressViewHeightConstraint = foodAddressView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var foodAddressViewBottomCostraint = foodAddressView.bottomAnchor.constraint(equalTo: bottomAnchor)
    private lazy var foodShopViewHeightConstraint = foodShopView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopCategoryViewHeightConstraint = shopCategoryView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopSubCategoryViewHeightConstraint = shopSubCategoryView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopDetailsViewHeightConstraint = shopDetailsView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopProductsViewHeightConstraint = shopProductsView.heightAnchor.constraint(equalToConstant: 0)
    private let hideCardViewConstant: CGFloat = 1000
    private lazy var cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                                 constant: hideCardViewConstant)
    
    func setupLayout() {
        addSubview(backgroundView)
        addSubview(foodAddressView)
        addSubview(foodShopView)
        addSubview(shopCategoryView)
        addSubview(shopSubCategoryView)
        addSubview(shopDetailsView)
        addSubview(shopProductsView)
        addSubview(dimmerView)
        addSubview(cardView)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodAddressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodAddressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodAddressViewHeightConstraint,
            foodAddressViewBottomCostraint,
            
            foodShopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodShopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodShopViewHeightConstraint,
            foodShopView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopCategoryViewHeightConstraint,
            shopCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopSubCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopSubCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopSubCategoryViewHeightConstraint,
            shopSubCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopDetailsViewHeightConstraint,
            shopDetailsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopProductsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopProductsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopProductsViewHeightConstraint,
            shopProductsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cardViewBottomConstraint,
            
            dimmerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dimmerView.topAnchor.constraint(equalTo: topAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
        updateMakeOrderButton()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            
            foodAddressViewHeightConstraint.constant = keyboardSize.height
            foodAddressViewBottomCostraint.constant = -keyboardSize.height + safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        foodAddressViewHeightConstraint.constant = 330
        foodAddressViewBottomCostraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.layoutIfNeeded()
        }
    }
}

extension FoodView: FoodViewDelegate {
    
    func toggle(_ hide: Bool, view: UIView, constraint: NSLayoutConstraint, dismiss: Bool = false) {
        if let baseFoodView = view as? BaseFoodView {
            switch hide {
            case true:
                baseFoodView.viewWillHide()
            case false:
                baseFoodView.viewWillShow()
            }
        }
        if hide {
            switch selectedView {
            case .cardView:
                constraint.constant = hideCardViewConstant
            default:
                constraint.constant = 0
            }
        } else {
            switch selectedView {
            case .address:
                constraint.constant = 330
            case .shop:
                constraint.constant = 450
            case .shopCategory, .productCategory, .shopProducts:
                constraint.constant = 620
            case .cardView:
                constraint.constant = 0
            default:
                constraint.constant = 400
            }
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: hide ? .curveEaseIn : .curveEaseOut,
            animations: { [weak self] in
                
                if hide && dismiss {
                    self?.backgroundView.alpha = 0
                } else {
                    self?.backgroundView.alpha = 0.3
                }
                
                self?.layoutIfNeeded()
            }, completion: { [weak self] _ in
                if let shopProductsView = view as? ShopProductsView {
                    shopProductsView.breadcrumbsCollectionView.isHidden = hide
                }
                
                if dismiss { self?.removeFromSuperview() }
            })
    }
    
    func shopMap() {
        toggle(true, view: foodAddressView, constraint: foodAddressViewHeightConstraint, dismiss: true)
    }
    
    func showShop(address: Address?) {
        selectedView = .shop
        foodShopView.address = address
        
        toggle(true, view: foodAddressView, constraint: foodAddressViewHeightConstraint)
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint)
        toggle(false, view: foodShopView, constraint: foodShopViewHeightConstraint)
    }
    
    func showShopCategory(shop: FoodShop?) {
        guard currentShopId == shop?.id || currentShopId == nil || shop == nil else {
            showEmptyDescriptionView()
            return
        }
        
        if (shop != nil) {
            selectedShop = shop
        }
        selectedView = .shopCategory
        
        if let shop = shop {
            shopSubCategoryView.shopNameLabel.text = shop.name
            shopSubCategoryView.loadSubCategorues(shopId: shop.id)
            
            shopCategoryView.shopNameLabel.text = shop.name
            shopCategoryView.loadCategorues(shopId: shop.id)
            
            shopDetailsView.shopNameLabel.text = shop.name
            shopDetailsView.loadDetails(shopId: shop.id)
        }
        
        toggle(true, view: foodShopView, constraint: foodShopViewHeightConstraint)
        toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint)
        toggle(true, view: shopDetailsView, constraint: shopDetailsViewHeightConstraint)
        toggle(false, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint)
    }
    
    func showProductCategory(category: ShopCategory?) {
        selectedView = .productCategory
        
        if let category = category {
            shopProductsView.categoryLabel.text = category.name
            shopSubCategoryView.categoryLabel.text = category.name
        }
        
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint)
        toggle(true, view: shopProductsView, constraint: shopProductsViewHeightConstraint)
        toggle(false, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint)
    }
    
    func showShopDetails() {
        selectedView = .shopDetails
        
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint)
        toggle(false, view: shopDetailsView, constraint: shopDetailsViewHeightConstraint)
    }
    
    func showShopProducts(shopId: Int?, subCategory: ShopSubCategory?) {
        selectedView = .shopProducts
        
        if let shopId = shopId,
           let subCategory = subCategory {
            shopProductsView.shopId = shopId
            shopProductsView.categoryIds.removeAll()
            shopProductsView.categoryIds.append(subCategory.id)
            shopProductsView.subCategoryLabel.text = subCategory.name
            shopProductsView.loadProducts(shopId: shopId, subCategoryId: subCategory.id)
        }
        
        toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint)
        toggle(false, view: shopProductsView, constraint: shopProductsViewHeightConstraint)
    }
    
    func showProductDetails(_ shopProduct: ShopProduct?) {
        guard let shopProduct = shopProduct, let shop = selectedShop else { return }
        productDetailsView.configure(with: .init(model: .init(id: shopProduct.id,
                                                              name: shopProduct.name,
                                                              price: Float(shopProduct.price ?? 0),
                                                              sale: 0,
                                                              hit: false,
                                                              composition: "вода, овсяная мука, напиток чайный (зеленый чай матча), соль.",
                                                              weight: "\(shopProduct.weight ?? 0)",
                                                              unit: "г",
                                                              producing: "Сады Придонья",
                                                              image: shopProduct.icon,
                                                              country: "Россия"),
                                                 shop: shop) { [weak self] in
                                                    self?.dismissProductDetails()
                                                 })
        
        cardView.configure(with: .init(contentView: productDetailsView,
                                       style: .light,
                                       paddingTop: 0,
                                       paddingBottom: 0,
                                       paddingX: 0,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.dismissProductDetails()
                                       }))
        toggle(true, view: shopProductsView, constraint: shopProductsViewHeightConstraint)
        selectedView = .cardView
        toggle(false, view: cardView, constraint: cardViewBottomConstraint)
    }
    
    func showCartView() {
        let cart = CartModel.getCart()
        cartView.cartViewDelegate = self
        
        cartView.configure(with: .init(cartRows: cart.rows,
                                       sum: cart.sum,
                                       deliveryTimeInMinutes: Int.random(in: 5...120),
                                       deliveryCost: 0,
                                       shopName: cart.shopName,
                                       backButtonTappedBlock: { [weak self] in
                                        self?.dismissCart()
                                       }))
        
        cardView.configure(with: .init(contentView: cartView,
                                       style: .light,
                                       paddingTop: 0,
                                       paddingBottom: 0,
                                       paddingX: 0,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.dismissCart()
                                       }))
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint)
        toggle(true, view: shopProductsView, constraint: shopProductsViewHeightConstraint)
        toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint)
        previousSelectedView = selectedView
        selectedView = .cardView
        toggle(false, view: cardView, constraint: cardViewBottomConstraint)
    }
    
    private func dismissProductDetails() {
        toggle(true,
               view: cardView,
               constraint: cardViewBottomConstraint)
        selectedView = .shopProducts
        toggle(false,
               view: shopProductsView,
               constraint: shopProductsViewHeightConstraint)
    }
    
    private func dismissCart() {
        toggle(true, view: cardView, constraint: cardViewBottomConstraint)
        selectedView = previousSelectedView
        switch previousSelectedView {
        case .shopCategory:
            toggle(false, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint)
        case .shopProducts:
            toggle(false, view: shopProductsView, constraint: shopProductsViewHeightConstraint)
        case .productCategory:
            toggle(false, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint)
        default:
            selectedView = .address
            toggle(false, view: foodAddressView, constraint: foodAddressViewHeightConstraint)
            return
        }
    }
    
    private func updateMakeOrderButton() {
        let cart = CartModel.getCart()
        let sumText = cart.sum > 0 ? cart.sum.currencyString() : nil
        [
            shopCategoryView,
            shopSubCategoryView,
            shopProductsView
        ].forEach { $0.updateMakeOrderButton(sum: sumText) }
        currentShopId = cart.shopId
    }
    
    private func showEmptyDescriptionView() {
        let contentView = TitledButtonsStackView()
        contentView.configure(with: .init(buttonsStackViewModel: .init(primaryTitle: FoodStrings.emptyCartConfirmation.text(),
                                                                       secondaryTitle: StringsHelper.cancel.text(),
                                                                       primaryButtonPressedBlock: { [weak self] in
                                                                        CartModel.shared.emptyCart()
                                                                        self?.hideCardView(completion: {
                                                                            self?.showEmptyCartView()
                                                                        })
                                                                       },
                                                                       secondaryButtonPressedBlock: { [weak self] in
                                                                        self?.hideCardView()
                                                                       }),
                                          titleColor: ColorHelper.secondaryText.color(),
                                          title: FoodStrings.emptyCartDescription.text()))
        cardView.configure(with: .init(contentView: contentView,
                                       style: .light,
                                       paddingBottom: 5,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.hideCardView()
                                       }))
        layoutIfNeeded()
        cardViewBottomConstraint.constant = 0
        dimmerView.show()
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    private func showEmptyCartView() {
        let contentView = EmptyCartView()
        contentView.configure(with: .init(backButtonTappedBlock: { [weak self] in
            self?.hideCardView()
        }))
        cardView.configure(with: .init(contentView: contentView,
                                       style: .light,
                                       paddingBottom: 5,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.hideCardView()
                                       }))
        layoutIfNeeded()
        cardViewBottomConstraint.constant = 0
        dimmerView.show()
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    private func hideCardView(completion: (() -> Void)? = nil) {
        cardViewBottomConstraint.constant = hideCardViewConstant
        dimmerView.hide()
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
}

// MARK: - ICartChangesObserver

extension FoodView: ICartChangesObserver {
    func cartUpdated() {
        DispatchQueue.main.async {
            self.updateMakeOrderButton()
        }
    }
}

extension FoodView: CartViewDelegate {
    func foodPaymentButtonTapped() {
        dismissCart()
    }
}
