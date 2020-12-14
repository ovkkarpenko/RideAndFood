//
//  ExpandedFoodActiveOrderView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 12.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ExpandedActiveOrderView: CustomViewWithAnimation {
    private var type: ActiveOrderViewType?
    private var activeOrderView: UIView?
    private lazy var taxiActiveOrderHandler = OrderTaxiModelHandler()
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
    
    private lazy var carName: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.text = "Белый Opel Astra"
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var carNumber: CarNumberView = {
        let view = CarNumberView(number: "T 342 TE", regionNumber: "777")
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var implementer: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var mainButton: CustomButton = {
        let view = CustomButton(type: .system)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var problemButton: UIButton = {
        let view = UIButton(type: .system)
        view.setTitleColor(Colors.getColor(.textBlack)(), for: .normal)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    init(type: ActiveOrderViewType) {
        self.type = type
        switch type {
        case .taxiActiveOrderView:
            activeOrderView = TaxiActiveOrderView()
        case .foodActiveOrderView:
            activeOrderView = FoodActiveOrderView()
        }
        
        super.init(frame: CGRect(x: UIScreen.main.bounds.origin.x, y: UIScreen.main.bounds.origin.y, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
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
        switch type! {
        case .taxiActiveOrderView:
            if let taxiActiveOrderView = activeOrderView as? TaxiActiveOrderView {
                taxiActiveOrderView.isLastView = true
                taxiActiveOrderView.isUserInteractionEnabled = true
                
                addSubview(stackView)
                
                stackView.insertArrangedSubview(taxiActiveOrderView, at: 0)
                stackView.addArrangedSubview(carName)
                stackView.addArrangedSubview(carNumber)
                
                // temp for test
                implementer.attributedText = setImplemeneter(name: "Ivan Ivanov")
                stackView.addArrangedSubview(implementer)
                
                mainButton.customizeButton(type: .blueButton)
                mainButton.setTitle(ActiveTaxiOrderStrings.getString(.addDelivery)(), for: .normal)
                
                stackView.addArrangedSubview(mainButton)
                
                problemButton.setTitle(ActiveTaxiOrderStrings.getString(.reportProblem)(), for: .normal)
                stackView.addArrangedSubview(problemButton)
                
                taxiActiveOrderView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.36).isActive = true
                taxiActiveOrderView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
                taxiActiveOrderView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            }
        case .foodActiveOrderView:
            if let foodActiveOrderView = activeOrderView as? FoodActiveOrderView {
                foodActiveOrderView.isLastView = true
                
                addSubview(stackView)
                
                stackView.addArrangedSubview(foodActiveOrderView)
                
                stackView.addArrangedSubview(implementer)
                
                mainButton.customizeButton(type: .greenButton)
                mainButton.setTitle(FoodActiveOrderStrings.getString(.callCourier)(), for: .normal)
                stackView.addArrangedSubview(mainButton)
                
                problemButton.setTitle(FoodActiveOrderStrings.getString(.cancelButton)(), for: .normal)
                stackView.addArrangedSubview(problemButton)
                
                foodActiveOrderView.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.45).isActive = true
                foodActiveOrderView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
                foodActiveOrderView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
            }
        }
        
        layoutStackView()
        
        NSLayoutConstraint.activate([stackView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
                                     stackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                                     stackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)])
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(deleteFromView))
        swipeGesture.direction = .down
        stackView.addGestureRecognizer(swipeGesture)

    }
    
    @objc private func deleteFromView() {
        dismiss { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    private func layoutStackView() {
        let buttonHeight: CGFloat = 50
        let labelHeight: CGFloat = padding
        
        if let type = type, type == .taxiActiveOrderView {
            carName.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
            carName.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
            carName.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
            
            carNumber.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
            carNumber.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        }
        
        implementer.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
        implementer.heightAnchor.constraint(equalToConstant: labelHeight).isActive = true
        implementer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        mainButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        mainButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        problemButton.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: padding).isActive = true
        problemButton.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
        problemButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    private func setImplemeneter(name: String) -> NSAttributedString? {
        switch type! {
        case .taxiActiveOrderView:
            let text = NSMutableAttributedString(string: ActiveTaxiOrderStrings.getString(.driver)(), attributes: [NSAttributedString.Key.foregroundColor : Colors.getColor(.textGray)()])
            text.append(NSAttributedString(string: name))
            return text
        case .foodActiveOrderView:
            return nil
        }
    }
}
