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
}

class FoodView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodSelectAddressView: FoodSelectAddressView = {
        let view = FoodSelectAddressView()
        view.showShopCallback = { [weak self] in
            guard let self = self else { return }
            
            self.selectedView = .shop
            self.toggle(true, constraint: self.foodSelectAddressViewTopConstraint)
            self.toggle(false, constraint: self.foodSelectShopViewTopConstraint)
        }
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodSelectShopView: FoodSelectShopView = {
        let view = FoodSelectShopView()
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
            toggle(true, constraint: foodSelectAddressViewTopConstraint, dismiss: selectedView == .address)
            toggle(true, constraint: foodSelectShopViewTopConstraint, dismiss: selectedView == .shop)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLoaded {
            isLoaded = true
            toggle(false, constraint: foodSelectAddressViewTopConstraint)
        }
    }
    
    private var isLoaded: Bool = false
    private var selectedView: SelectedViewType = .address
    
    private let padding: CGFloat = 20
    private let foodViewShownPadding: CGFloat = 300
    private let foodViewHiddenPadding: CGFloat = 800
    
    private lazy var foodSelectAddressViewTopConstraint = foodSelectAddressView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: foodViewHiddenPadding)
    private lazy var foodSelectAddressViewBottomCostraint = foodSelectAddressView.bottomAnchor.constraint(equalTo: bottomAnchor)
    
    private lazy var foodSelectShopViewTopConstraint = foodSelectShopView.topAnchor.constraint(
        equalTo: topAnchor,
        constant: foodViewHiddenPadding)
    
    func setupLayout() {
        addSubview(backgroundView)
        addSubview(foodSelectAddressView)
        addSubview(foodSelectShopView)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodSelectAddressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodSelectAddressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodSelectAddressViewTopConstraint,
            foodSelectAddressViewBottomCostraint,
            
            foodSelectShopView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodSelectShopView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodSelectShopViewTopConstraint,
            foodSelectShopView.bottomAnchor.constraint(equalTo: bottomAnchor)
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
            
            foodSelectAddressViewTopConstraint.constant = -keyboardSize.height + foodViewShownPadding
            foodSelectAddressViewBottomCostraint.constant = -keyboardSize.height + safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        foodSelectAddressViewTopConstraint.constant = foodViewShownPadding
        foodSelectAddressViewBottomCostraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.layoutIfNeeded()
        }
    }
}
