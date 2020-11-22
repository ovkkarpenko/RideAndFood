//
//  DimmerView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class DimmerView: UIView {
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Public methods
    
    func hide() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0
        }
    }
    
    func show() {
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        alpha = 0
        backgroundColor = ColorHelper.transparentBlack.color()
    }
}
