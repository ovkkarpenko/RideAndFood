//
//  BaseFoodView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 10.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class BaseFoodView: UIView {
    
    // MARK: - UI
    
    internal lazy var makeOrderButton: PrimaryButton = {
        let button = PrimaryButton()
        button.heightConstraint.constant = 0
        button.setTitleColor(ColorHelper.primaryButtonText.color(), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var makeOrderButtonHeightConstraint = makeOrderButton.heightAnchor.constraint(equalToConstant: 0)
    private let horizontalPadding: CGFloat = 25
    private var isShown: Bool = false
    private var sumText: String?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Internal methods
    
    internal func updateMakeOrderButton(sum: String?) {
        sumText = sum
        
        if sum != nil {
            if isShown {
                showMakeOrderButton()
            }
        } else {
            hideMakeOrderButton()
        }
    }
    
    internal func viewWillShow() {
        showMakeOrderButton()
        isShown = true
    }
    
    internal func viewWillHide() {
        hideMakeOrderButton()
        isShown = false
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        let safeAreaBottom = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.bottom ?? 0
        addSubview(makeOrderButton)
        
        NSLayoutConstraint.activate([
            makeOrderButtonHeightConstraint,
            makeOrderButton.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                     constant: horizontalPadding),
            makeOrderButton.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                      constant: -horizontalPadding),
            makeOrderButton.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                    constant: -safeAreaBottom - 5)
        ])
    }
    
    private func showMakeOrderButton() {
        guard let sum = sumText else {
            return
        }
        makeOrderButton.setTitles(left: FoodStrings.makeOrder.text(),
                                  right: sum)
        makeOrderButton.heightConstraint.constant = 50
        makeOrderButtonHeightConstraint.isActive = false
        UIView.animate(withDuration: 0.2) {
            self.makeOrderButton.alpha = 1
        }
        self.layoutIfNeeded()
    }
    
    private func hideMakeOrderButton() {
        makeOrderButton.heightConstraint.constant = 0
        makeOrderButtonHeightConstraint.isActive = true
        UIView.animate(withDuration: 0.2) {
            self.makeOrderButton.alpha = 0
        } completion: { _ in
            self.makeOrderButton.setAttributedTitle(nil, for: .normal)
            self.layoutIfNeeded()
        }
    }
}
