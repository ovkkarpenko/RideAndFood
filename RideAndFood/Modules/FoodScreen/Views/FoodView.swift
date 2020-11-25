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
    func shopMap()
    func showShop(address: Address?)
    func showShopCategory(shop: FoodShop?)
    func showShopDetails()
    func showShopProducts(shopId: Int?, subCategory: ShopSubCategory?)
    func showProductCategory(category: ShopCategory?)
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
            toggle(true, view: foodAddressView, constraint: foodAddressViewHeightConstraint, dismiss: selectedView == .address)
            toggle(true, view: foodShopView, constraint: foodShopViewHeightConstraint, dismiss: selectedView == .shop)
            toggle(true, view: shopCategoryView, constraint: shopCategoryViewHeightConstraint, dismiss: selectedView == .shopCategory)
            toggle(true, view: shopSubCategoryView, constraint: shopSubCategoryViewHeightConstraint, dismiss: selectedView == .productCategory)
            toggle(true, view: shopDetailsView, constraint: shopDetailsViewHeightConstraint, dismiss: selectedView == .shopDetails)
            toggle(true, view: shopProductsView, constraint: shopProductsViewHeightConstraint, dismiss: selectedView == .shopProducts)
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
    
    private let padding: CGFloat = 20
    
    private lazy var foodAddressViewHeightConstraint = foodAddressView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var foodAddressViewBottomCostraint = foodAddressView.bottomAnchor.constraint(equalTo: bottomAnchor)
    private lazy var foodShopViewHeightConstraint = foodShopView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopCategoryViewHeightConstraint = shopCategoryView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopSubCategoryViewHeightConstraint = shopSubCategoryView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopDetailsViewHeightConstraint = shopDetailsView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var shopProductsViewHeightConstraint = shopProductsView.heightAnchor.constraint(equalToConstant: 0)
    
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
        if hide {
            constraint.constant = 0
        } else {
            if selectedView == .address {
                constraint.constant = 330
            } else if selectedView == .shop {
                constraint.constant = 450
            } else if selectedView == .shopCategory {
                constraint.constant = 620
            } else if selectedView == .productCategory {
                constraint.constant = 620
            } else if selectedView == .shopProducts {
                constraint.constant = 620
            } else {
                constraint.constant = 400
            }
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: hide ? .curveEaseIn : .curveEaseOut,
            animations: { [weak self] in
                
                if hide {
                    if dismiss { self?.backgroundView.alpha = 0 }
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
}
