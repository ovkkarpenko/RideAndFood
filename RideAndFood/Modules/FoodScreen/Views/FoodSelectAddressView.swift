//
//  FoodSelectAddressView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 18.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

class FoodSelectAddressView: UIView {
    
    private lazy var addressIcon: UIImageView = {
        let image = UIImage(named: "subtract", in: Bundle.init(path: "Images/Icons"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var addressTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        //        textField.placeholder = AddAddressesStrings.addres.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var showMapButton: UIStackView = {
        var leftLineLayer = CALayer()
        leftLineLayer.backgroundColor = ColorHelper.disabledButton.color()?.cgColor
        leftLineLayer.frame = CGRect(x: 5, y: -10, width: 1, height: 23)
        
        let leftLine = UIView()
        leftLine.layer.addSublayer(leftLineLayer)
        
        let button = UIButton()
        button.setTitle("Text", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        //        button.addTarget(self, action: #selector(showMapButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "rightArrow", in: Bundle.init(path: "Images/Icons"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 5, width: 9.5, height: 7.3)
        
        let stackView = UIStackView(arrangedSubviews: [leftLine, button, imageView])
        stackView.distribution = .equalCentering
        stackView.alignment = .center
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    private let padding: CGFloat = 20
    
    func setupLayout() {
        addSubview(addressIcon)
        addSubview(addressTextField)
        addSubview(showMapButton)
        
        NSLayoutConstraint.activate([
            addressIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addressIcon.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            addressTextField.leadingAnchor.constraint(equalTo: addressIcon.leadingAnchor, constant: padding),
            addressTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addressTextField.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            showMapButton.widthAnchor.constraint(equalToConstant: 60),
            showMapButton.heightAnchor.constraint(equalToConstant: 23),
            showMapButton.topAnchor.constraint(equalTo: addressTextField.topAnchor, constant: -5),
            showMapButton.trailingAnchor.constraint(equalTo: addressTextField.trailingAnchor),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
