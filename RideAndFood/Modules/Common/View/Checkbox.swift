//
//  Checkbox.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class Checkbox: UIView {
    
    // MARK: - Public properties
    
    var isChecked = false {
        didSet {
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.mark.alpha = self.isChecked ? 1 : 0
            }
            if let valueChangedCallback = valueChangedCallback {
                valueChangedCallback(isChecked)
            }
        }
    }
    
    var valueChangedCallback: ((Bool) -> Void)?
    
    // MARK: - UI
    
    private let mark: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.primary.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.alpha = 0
        return view
    }()
    private let padding: CGFloat = 5
    private let size: CGFloat = 16
    private lazy var cornerRadius = size / 4
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycke methods
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mark.layer.cornerRadius = mark.bounds.width / 2
        layer.cornerRadius = cornerRadius
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        backgroundColor = ColorHelper.controlBackground.color()
        
        addSubview(mark)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: size),
            widthAnchor.constraint(equalToConstant: size),
            mark.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            mark.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            mark.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            mark.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pressed)))
    }
    
    @objc private func pressed() {
        isChecked.toggle()
    }
}
