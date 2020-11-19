//
//  DeliveryAddressView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

class DeliveryAddressView: UIView {
    
    lazy var apartmentTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.apartment.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var doorphoneTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.doorphone.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var entranceTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.entrance.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var floorTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.floor.text()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var commentForCourierTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.placeholder = AddAddressesStrings.commentForCourier.text()
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
        
        addSubview(apartmentTextField)
        addSubview(doorphoneTextField)
        addSubview(entranceTextField)
        addSubview(floorTextField)
        addSubview(commentForCourierTextField)
        
        NSLayoutConstraint.activate([
            apartmentTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            apartmentTextField.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            apartmentTextField.widthAnchor.constraint(equalToConstant: 170),
            
            doorphoneTextField.leadingAnchor.constraint(equalTo: apartmentTextField.trailingAnchor, constant: padding),
            doorphoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            doorphoneTextField.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            entranceTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            entranceTextField.topAnchor.constraint(equalTo: apartmentTextField.bottomAnchor, constant: padding),
            entranceTextField.widthAnchor.constraint(equalToConstant: 170),
            
            floorTextField.leadingAnchor.constraint(equalTo: entranceTextField.trailingAnchor, constant: padding),
            floorTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            floorTextField.topAnchor.constraint(equalTo: doorphoneTextField.bottomAnchor, constant: padding),
            
            commentForCourierTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            commentForCourierTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            commentForCourierTextField.topAnchor.constraint(equalTo: entranceTextField.bottomAnchor, constant: padding),
        ])
    }
    
    func getUserInputs() -> (Int, Int, Int, Int, String) {
        return (Int(apartmentTextField.text ?? "") ?? 0, Int(doorphoneTextField.text ?? "") ?? 0, Int(entranceTextField.text ?? "") ?? 0, Int(floorTextField.text ?? "") ?? 0, commentForCourierTextField.text ?? "")
    }
}
