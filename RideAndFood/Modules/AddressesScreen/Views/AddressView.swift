//
//  AddressView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

class AddressView: UIView {
    
    var showMapButtonCallback: (() -> ())?
    
    lazy var addressNameTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.addresName.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var addressIcon: UIImageView = {
        let image = UIImage(named: "subtract", in: Bundle.init(path: "Images/Icons"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addressTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.addres.text()
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
        button.setTitle(AddAddressesStrings.mapButton.text(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        button.addTarget(self, action: #selector(showMapButtonPressed), for: .touchUpInside)
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
    
    lazy var commentForDriverTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.commentForDriver.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
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
        backgroundColor = ColorHelper.background.color()
        
        addSubview(addressNameTextField)
        addSubview(addressIcon)
        addSubview(addressTextField)
        addSubview(showMapButton)
        addSubview(commentForDriverTextField)
        
        NSLayoutConstraint.activate([
            addressNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addressNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addressNameTextField.topAnchor.constraint(equalTo: topAnchor),
            
            addressIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addressIcon.topAnchor.constraint(equalTo: addressNameTextField.bottomAnchor, constant: padding),
            
            addressTextField.leadingAnchor.constraint(equalTo: addressIcon.leadingAnchor, constant: padding),
            addressTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addressTextField.topAnchor.constraint(equalTo: addressNameTextField.bottomAnchor, constant: padding),
            
            showMapButton.widthAnchor.constraint(equalToConstant: 60),
            showMapButton.heightAnchor.constraint(equalToConstant: 23),
            showMapButton.topAnchor.constraint(equalTo: addressTextField.topAnchor, constant: -5),
            showMapButton.rightAnchor.constraint(equalTo: addressTextField.rightAnchor),
            
            commentForDriverTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commentForDriverTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            commentForDriverTextField.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: padding)
        ])
    }
    
    func setAddress(_ address: String) {
        addressTextField.text = address
    }
    
    func getUserInputs() -> (String, String, String) {
        return (addressNameTextField.text ?? "", addressTextField.text ?? "", commentForDriverTextField.text ?? "")
    }
    
    @objc private func showMapButtonPressed() {
        showMapButtonCallback?()
    }
}
