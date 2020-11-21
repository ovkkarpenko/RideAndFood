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
    case category
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
        view.showShopCallback = { [weak self] address in
            guard let self = self else { return }
            
            self.selectedView = .shop
            self.foodShopView.addressTextField.text = address.address
            self.foodShopView.addressNameLabel.text = address.name
            
            self.toggle(true, constraint: self.foodAddressViewTopConstraint)
            self.toggle(false, constraint: self.foodShopViewTopConstraint)
        }
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodShopView: FoodShopView = {
        let view = FoodShopView()
        view.showCategoryCallback = { [weak self] shop in
            guard let self = self else { return }
            
            self.selectedView = .category
            
            self.toggle(true, constraint: self.foodShopViewTopConstraint)
            self.toggle(false, constraint: self.foodCategoryViewTopConstraint)
        }
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodCategoryView: FoodCategoryView = {
        let view = FoodCategoryView()
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
            toggle(true, constraint: foodCategoryViewTopConstraint, dismiss: selectedView == .category)
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
    private let foodViewShownPadding: CGFloat = 300
    private let foodViewHiddenPadding: CGFloat = 800
    
    private lazy var foodAddressViewTopConstraint = foodAddressView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: foodViewHiddenPadding)
    private lazy var foodAddressViewBottomCostraint = foodAddressView.bottomAnchor.constraint(equalTo: bottomAnchor)
    
    private lazy var foodShopViewTopConstraint = foodShopView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: foodViewHiddenPadding)
    
    private lazy var foodCategoryViewTopConstraint = foodCategoryView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: foodViewHiddenPadding)
    
    func setupLayout() {
        addSubview(backgroundView)
        addSubview(foodAddressView)
        addSubview(foodShopView)
        addSubview(foodCategoryView)
        
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
            
            foodCategoryView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodCategoryView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodCategoryViewTopConstraint,
            foodCategoryView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    
    func toggle(_ hide: Bool, constraint: NSLayoutConstraint, dismiss: Bool = false) {
        if hide {
            if dismiss { backgroundView.alpha = 0 }
            constraint.constant = foodViewHiddenPadding
        } else {
            backgroundView.alpha = 0.3
            constraint.constant = foodViewShownPadding
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
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            
            foodAddressViewTopConstraint.constant = -keyboardSize.height + foodViewShownPadding
            foodAddressViewBottomCostraint.constant = -keyboardSize.height + safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        foodAddressViewTopConstraint.constant = foodViewShownPadding
        foodAddressViewBottomCostraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.layoutIfNeeded()
        }
    }
}
