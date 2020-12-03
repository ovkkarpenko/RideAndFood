//
//  SelectTariffView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 03.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class SelectTariffView: UIView {
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: SelectTariffViewDelegate?
    var viewType: SelectTariffViewType?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private let offset: CGFloat = 400
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: 1000+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1000-offset)
    
    private func setupUI() {
        addSubview(contentView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint
        ])
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss() {
        //        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveLinear]) { [weak self] in
        //            guard let self = self else { return }
        //            self.backView.layer.frame.origin.y += self.backView.frame.height
        //
        //        } completion: { [weak self] _ in
        //            self?.removeFromSuperview()
        //        }
    }
}
