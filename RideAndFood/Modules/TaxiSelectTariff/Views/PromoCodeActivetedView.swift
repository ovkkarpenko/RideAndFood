//
//  PromoCodeActivetedView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 08.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodeActivetedView: UIView {
    
    var promoCode: String?
    
    var dismissCallback: (() -> ())?
    var ifPromoCodeIsValidCallback: ((String?) -> ())?
    
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
    
    private lazy var successImageView: UIImageView = {
        let image = UIImage(named: "PromocodeSuccess")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var activatedTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.textColor = UIColor(red: 0.204, green: 0.78, blue: 0.349, alpha: 1)
        label.text = SelectTariffStrings.promoCodeActivatedTitle.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activatedDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 17)
        label.numberOfLines = 3
        label.textColor = ColorHelper.secondaryText.color()
        label.text = SelectTariffStrings.promoCodeActivatedDescription.text()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        super.touchesEnded(touches, with: event)
        
        if touches.first?.view == self {
            dismiss { [weak self] in
                self?.dismissCallback?()
                self?.removeFromSuperview()
            }
        }
    }
    
    private let offset: CGFloat = UIScreen.main.bounds.height-210
    private let padding: CGFloat = 20
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(successImageView)
        contentView.addSubview(activatedTitleLabel)
        contentView.addSubview(activatedDescriptionLabel)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            successImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            successImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            activatedTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            activatedTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            activatedTitleLabel.topAnchor.constraint(equalTo: successImageView.bottomAnchor, constant: 10),
            
            activatedDescriptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activatedDescriptionLabel.topAnchor.constraint(equalTo: activatedTitleLabel.bottomAnchor, constant: 3),
            activatedDescriptionLabel.widthAnchor.constraint(equalToConstant: 250)
        ])  
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss(_ completion: (() -> ())?) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { [weak self] _ in
            self?.ifPromoCodeIsValidCallback?(self?.promoCode)
            completion?()
        }
    }
}
