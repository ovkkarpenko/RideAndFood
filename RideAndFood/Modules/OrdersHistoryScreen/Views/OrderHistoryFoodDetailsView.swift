//
//  OrderHistoryFoodDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OrderHistoryFoodDetailsView: UIView {
    
    var hideViewCallback: (() -> ())?
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.alpha = 0.3
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 15
        view.alpha = 0
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view == transparentView {
            toggle(hide: true)
        }
    }
    
    private func setupUI() {
        addSubview(transparentView)
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            transparentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparentView.topAnchor.constraint(equalTo: topAnchor),
            transparentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.centerYAnchor.constraint(equalTo: centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: centerXAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 390),
        ])
    }
    
    func setWidth(width: CGFloat) {
        contentView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func toggle(hide: Bool) {
        if !hide { isHidden = false }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: hide ? .curveEaseIn : .curveEaseOut,
            animations: { [weak self] in
                self?.contentView.alpha = hide ? 0 : 1
                self?.alpha = 1
            },
            completion: { [weak self]_ in
                if hide { self?.isHidden = true }
            })
    }
}
