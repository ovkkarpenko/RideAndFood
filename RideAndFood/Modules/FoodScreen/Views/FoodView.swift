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

class FoodView: UIView {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodView: UIView = {
        let view = FoodSelectAddressView()
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
            toggle(hide: true)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isLoaded {
            isLoaded = true
            toggle(hide: false)
        }
    }
    
    private var isLoaded: Bool = false
    
    private let foodViewShownPadding: CGFloat = 300
    private let foodViewHiddenPadding: CGFloat = 800
    
    private lazy var foodViewTopConstraint = foodView.topAnchor.constraint(equalTo: topAnchor, constant: foodViewHiddenPadding)
    
    func setupLayout() {
        addSubview(backgroundView)
        addSubview(foodView)
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodView.leadingAnchor.constraint(equalTo: leadingAnchor),
            foodView.trailingAnchor.constraint(equalTo: trailingAnchor),
            foodViewTopConstraint,
            foodView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func toggle(hide: Bool) {
        var animationOptions: UIView.AnimationOptions
        if hide {
            backgroundView.alpha = 0
            foodViewTopConstraint.constant = foodViewHiddenPadding
            animationOptions = .curveEaseIn
        } else {
            backgroundView.alpha = 0.3
            foodViewTopConstraint.constant = foodViewShownPadding
            animationOptions = .curveEaseOut
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: animationOptions, animations: { [weak self] in
                
                self?.layoutIfNeeded()
            }, completion: { [weak self] _ in
                
                if hide {
                    self?.removeFromSuperview()
                }
            })
    }
}
