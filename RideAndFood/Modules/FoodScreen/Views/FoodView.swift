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
}

protocol FoodViewDelegate {
    func showShop(address: Address?)
    func showShopCategory(shop: FoodShop?)
    func showShopDetails()
    func showShopProducts(shopId: Int?, subCategory: ShopSubCategory?)
    func showProductCategory(category: ShopCategory?)
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
            toggle(true, view: foodAddressView, constraint: foodAddressViewTopConstraint, dismiss: selectedView == .address)
            toggle(true, view: foodShopView, constraint: foodShopViewTopConstraint, dismiss: selectedView == .shop)
            toggle(true, view: shopCategoryView, constraint: shopCategoryViewTopConstraint, dismiss: selectedView == .shopCategory)
            toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewTopConstraint, dismiss: selectedView == .productCategory)
            toggle(true, view: shopDetailsView, constraint: shopDetailsViewTopConstraint, dismiss: selectedView == .shopDetails)
            toggle(true, view: shopProductsView, constraint: shopProductsViewTopConstraint, dismiss: selectedView == .shopProducts)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLoaded {
            isLoaded = true
            toggle(false, view: foodAddressView, constraint: foodAddressViewTopConstraint)
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
    
    private lazy var shopSubCategoryViewTopConstraint = shopSubCategoryView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    
    private lazy var shopDetailsViewTopConstraint = shopDetailsView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    
    private lazy var shopProductsViewTopConstraint = shopProductsView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: hiddenPadding)
    
    func setupLayout() {
        addSubview(backgroundView)
        addSubview(foodAddressView)
        addSubview(foodShopView)
        addSubview(shopCategoryView)
        addSubview(shopSubCategoryView)
        addSubview(shopDetailsView)
        addSubview(shopProductsView)
        
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
            
            shopSubCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopSubCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopSubCategoryViewTopConstraint,
            shopSubCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopDetailsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopDetailsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopDetailsViewTopConstraint,
            shopDetailsView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            shopProductsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shopProductsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shopProductsViewTopConstraint,
            shopProductsView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    func toggle(_ hide: Bool, view: UIView,constraint: NSLayoutConstraint, dismiss: Bool = false) {
        if hide {
            constraint.constant = hiddenPadding
        } else {
            if selectedView == .shopCategory || selectedView == .productCategory || selectedView == .shopProducts {
                constraint.constant = shownPadding-200
            }
            else { constraint.constant = shownPadding }
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: hide ? .curveEaseIn : .curveEaseOut,
            animations: { [weak self] in
                
                if hide {
                    view.alpha = 0
                    if dismiss { self?.backgroundView.alpha = 0 }
                } else {
                    view.alpha = 1
                    self?.backgroundView.alpha = 0.3
                }
                
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
        
        toggle(true, view: foodAddressView, constraint: foodAddressViewTopConstraint)
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewTopConstraint)
        toggle(false, view: foodShopView, constraint: foodShopViewTopConstraint)
    }
    
    func showShopCategory(shop: FoodShop?) {
        selectedView = .shopCategory
        
        if let shop = shop {
            shopSubCategoryView.shopNameLabel.text = shop.name
            shopSubCategoryView.loadSubCategorues(shopId: shop.id)
            
            shopCategoryView.shopNameLabel.text = shop.name
            shopCategoryView.loadCategorues(shopId: shop.id)
            
            shopDetailsView.shopNameLabel.text = shop.name
            shopDetailsView.loadDetails(shopId: shop.id)
        }
        
        toggle(true, view: foodShopView, constraint: foodShopViewTopConstraint)
        toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewTopConstraint)
        toggle(true, view: shopDetailsView, constraint: shopDetailsViewTopConstraint)
        toggle(false, view: shopCategoryView, constraint: shopCategoryViewTopConstraint)
    }
    
    func showProductCategory(category: ShopCategory?) {
        selectedView = .productCategory
        
        if let category = category {
            shopProductsView.categoryLabel.text = category.name
            shopSubCategoryView.categoryLabel.text = category.name
        }
        
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewTopConstraint)
        toggle(true, view: shopProductsView, constraint: shopProductsViewTopConstraint)
        toggle(false, view: shopSubCategoryView, constraint: shopSubCategoryViewTopConstraint)
    }
    
    func showShopDetails() {
        selectedView = .shopDetails
        
        toggle(true, view: shopCategoryView, constraint: shopCategoryViewTopConstraint)
        toggle(false, view: shopDetailsView, constraint: shopDetailsViewTopConstraint)
    }
    
    func showShopProducts(shopId: Int?, subCategory: ShopSubCategory?) {
        selectedView = .shopProducts
        
        if let shopId = shopId,
           let subCategory = subCategory {
            shopProductsView.subCategoryLabel.text = subCategory.name
            shopProductsView.loadProducts(shopId: shopId, subCategoryId: subCategory.id)
        }
        
        toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewTopConstraint)
        toggle(false, view: shopProductsView, constraint: shopProductsViewTopConstraint)
    }
}
