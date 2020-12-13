//
//  ExpandedFoodActiveOrderView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 12.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ExpandedFoodActiveOrderView: CustomViewWithAnimation {
     var foodActiveOrderView: FoodActiveOrderView?
    private let padding: CGFloat = 25
    
    private lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 20
        view.alignment = .center
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var implementer: UILabel = {
        let view = UILabel()
        view.text = "Курьер: какой-то человек"
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var callCourierButton: CustomButton = {
        let view = CustomButton(type: .system)
        view.customizeButton(type: .greenButton)
        view.isUserInteractionEnabled = true
        view.setTitle(FoodActiveOrderStrings.getString(.callCourier)(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var cancelButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle(FoodActiveOrderStrings.getString(.cancelButton)(), for: .normal)
        view.isUserInteractionEnabled = true
        view.setTitleColor(Colors.getColor(.textBlack)(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(foodActiveOrderView: FoodActiveOrderView) {
        self.foodActiveOrderView = FoodActiveOrderView()
        super.init(frame: CGRect(x: 0, y: foodActiveOrderView.frame.origin.y, width: foodActiveOrderView.frame.width, height: 400))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        setupLayout()
    }
    
    // MARK: - private methods
    private func setupLayout() {
        if let foodActiveOrderView = foodActiveOrderView {
            foodActiveOrderView.gestureRecognizers?.removeAll()
            foodActiveOrderView.isLastView = true
            foodActiveOrderView.isHidden = false
            
            addSubview(stackView)
            
            stackView.addArrangedSubview(foodActiveOrderView)
            stackView.addArrangedSubview(implementer)
            stackView.addArrangedSubview(callCourierButton)
            stackView.addArrangedSubview(cancelButton)
            
            foodActiveOrderView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.4).isActive = true
            foodActiveOrderView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
            foodActiveOrderView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            
            layoutStackView()
            
            NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                                         stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                         stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)])
            
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteFromView))
            swipeGesture.direction = .down
            addGestureRecognizer(swipeGesture)
        }
    }
    
    @objc private func deleteFromView() {
        dismiss { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    private func layoutStackView() {
        let buttonHeight: CGFloat = 50
        
        implementer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
        implementer.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        implementer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        callCourierButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
        callCourierButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        callCourierButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        cancelButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
