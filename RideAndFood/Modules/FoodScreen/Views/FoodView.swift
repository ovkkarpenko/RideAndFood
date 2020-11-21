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
    case productCategory
}

protocol FoodViewDelegate {
    func showShop(address: Address?)
    func showShopCategory(shop: FoodShop?)
    func showProductCategory(category: ShopCategories?)
}

class FoodView: UIView {
    
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
    
    private lazy var productCategoryView: ProductCategoryView = {
        let view = ProductCategoryView()
        view.delegate = self
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == backgroundView {
            toggle(true, constraint: foodAddressViewTopConstraint, dismiss: selectedView == .address)
            toggle(true, constraint: foodShopViewTopConstraint, dismiss: selectedView == .shop)
            toggle(true, constraint: shopCategoryViewTopConstraint, dismiss: selectedView == .shopCategory)
            toggle(true, constraint: productCategoryViewTopConstraint, dismiss: selectedView == .productCategory)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLoaded {
            isLoaded = true
            toggle(false, constraint: foodAddressViewTopConstraint)
        }
    }
    
    private var isLoaded: Bool = false
    private var selectedView: SelectedViewType = .address
    
    private let padding: CGFloat = 20
    private let shownPadding: CGFloat = 300
    private let hiddenPadding: CGFloat = 1000
    
    private lazy var foodAddressViewTopConstraint = foodAddressView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    private lazy var foodAddressViewBottomCostraint = foodAddressView.bottomAnchor.constraint(equalTo: bottomAnchor)
    
    private lazy var foodShopViewTopConstraint = foodShopView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    
    private lazy var shopCategoryViewTopConstraint = shopCategoryView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    
    private lazy var productCategoryViewTopConstraint = productCategoryView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    
    func setupLayout() {
        addSubview(backgroundView)
        addSubview(foodAddressView)
        addSubview(foodShopView)
        addSubview(shopCategoryView)
        addSubview(productCategoryView)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodAddressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodAddressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodAddressViewTopConstraint,
            foodAddressViewBottomCostraint,
            
            foodShopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodShopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodShopViewTopConstraint,
            foodShopView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopCategoryViewTopConstraint,
            shopCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            productCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productCategoryViewTopConstraint,
            productCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            
            foodAddressViewTopConstraint.constant = -keyboardSize.height + shownPadding
            foodAddressViewBottomCostraint.constant = -keyboardSize.height + safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        foodAddressViewTopConstraint.constant = shownPadding
        foodAddressViewBottomCostraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.layoutIfNeeded()
        }
    }
}

extension FoodView: FoodViewDelegate {
    
    func toggle(_ hide: Bool, constraint: NSLayoutConstraint, dismiss: Bool = false) {
        if hide {
            if dismiss { backgroundView.alpha = 0 }
            constraint.constant = hiddenPadding
        } else {
            backgroundView.alpha = 0.3
            constraint.constant = selectedView == .shopCategory || selectedView == .productCategory ? shownPadding-200 : shownPadding
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: hide ? .curveEaseIn : .curveEaseOut,
            animations: { [weak self] in
                self?.layoutIfNeeded()
            }, completion: { [weak self] _ in
                if dismiss { self?.removeFromSuperview() }
            })
    }
    
    func showShop(address: Address?) {
        selectedView = .shop
        
        if let address = address {
            foodShopView.addressTextField.text = address.address
            foodShopView.addressNameLabel.text = address.name
        }
        
        toggle(true, constraint: foodAddressViewTopConstraint)
        toggle(true, constraint: shopCategoryViewTopConstraint)
        toggle(false, constraint: foodShopViewTopConstraint)
    }
    
    func showShopCategory(shop: FoodShop?) {
        selectedView = .shopCategory
        
        if let shop = shop {
            productCategoryView.shopNameLabel.text = shop.name
            shopCategoryView.shopNameLabel.text = shop.name
            shopCategoryView.loadCategorues(shopId: shop.id)
        }
        
        toggle(true, constraint: foodShopViewTopConstraint)
        toggle(true, constraint: productCategoryViewTopConstraint)
        toggle(false, constraint: shopCategoryViewTopConstraint)
    }
    
    func showProductCategory(category: ShopCategories?) {
        selectedView = .productCategory
        
        if let category = category {
            productCategoryView.categoryLabel.text = category.name
        }
        
        toggle(true, constraint: shopCategoryViewTopConstraint)
        toggle(false, constraint: productCategoryViewTopConstraint)
    }
}
