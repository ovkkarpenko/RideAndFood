//
//  TaxiFoundView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiFoundView: UIView, CustromViewProtocol {
    
    var order: TaxiOrder?
    weak var delegate: SelectTariffViewDelegate?
    
    private let contentView: UIView = {
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
    
    private let transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tripDurationView: TripDurationView = {
        let view = TripDurationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let strokeImageView: UIImageView = {
        let image = UIImage(named: "stroke2")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var taxiOrderDetailsView: TaxiOrderDetailsView = {
        let view = TaxiOrderDetailsView()
        view.config()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: FoodStrings.confirm.text())
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cencelButton: PrimaryButton = {
        let button = PrimaryButton(title: PaymentStrings.celncelButtonTitle.text())
        button.addTarget(self, action: #selector(cencelButtonPressed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private let padding: CGFloat = 20
    private let offset: CGFloat = UIScreen.main.bounds.height-610
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    private func setupUI() {
        addSubview(transparentView)
        addSubview(contentView)
        contentView.addSubview(tripDurationView)
        contentView.addSubview(strokeImageView)
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        contentView.addSubview(taxiOrderDetailsView)
        contentView.addSubview(confirmButton)
        contentView.addSubview(cencelButton)
        
        NSLayoutConstraint.activate([
            transparentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparentView.topAnchor.constraint(equalTo: topAnchor),
            transparentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            tripDurationView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tripDurationView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            strokeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            strokeImageView.topAnchor.constraint(equalTo: tripDurationView.bottomAnchor, constant: padding+50),
            strokeImageView.widthAnchor.constraint(equalToConstant: 25),
            strokeImageView.heightAnchor.constraint(equalToConstant: 65),
            
            firstLabel.leadingAnchor.constraint(equalTo: strokeImageView.trailingAnchor, constant: padding),
            firstLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding+70),
            
            secondLabel.leadingAnchor.constraint(equalTo: strokeImageView.trailingAnchor, constant: padding),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: padding+5),
            
            taxiOrderDetailsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            taxiOrderDetailsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            taxiOrderDetailsView.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: padding),
            taxiOrderDetailsView.heightAnchor.constraint(equalToConstant: 290),
            
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            confirmButton.topAnchor.constraint(equalTo: taxiOrderDetailsView.bottomAnchor, constant: padding),
            
            cencelButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            cencelButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            cencelButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor),
        ])
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.transparentView.alpha = 0.3
            self?.layoutIfNeeded()
        }
        
        firstLabel.text = order?.from
        secondLabel.text = order?.to
    }
    
    func dismiss(_ completion: (() -> ())?) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            if completion != nil { self?.transparentView.alpha = 0 }
            self?.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    @objc private func confirmButtonPressed() {
        guard let order = order else { return }
        
        CoreDataManager.shared.addEntity(TaxiOrderDB.self, properties: [
            "id": 1,
            "from": order.from,
            "to": order.to
        ])
        
        dismiss { [weak self] in
            self?.removeFromSuperview()
        }
        delegate?.confirmOrderButtonPressed()
    }
    
    @objc private func cencelButtonPressed() {
        dismiss { [weak self] in
            self?.removeFromSuperview()
        }
        delegate?.cencelOrderButtonPressed()
    }
}
