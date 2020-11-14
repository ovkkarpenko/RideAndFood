//
//  CustomTextView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 10.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

enum TextViewType: Int {
    case fromAddress = 1
    case toAddress = 2
}

class CustomTextView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var texField: UITextField!
    @IBOutlet weak var locationImage: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var verticalSplitterView: UIView!
    
    static let CUSTOM_TEXT_VIEW_NIB = "CustomTextView"
    
    private var textViewType: TextViewType! {
        didSet {
            customizeViews()
        }
    }
    
    private var isTextFieldDisable = true {
        didSet {
            if isTextFieldDisable != oldValue {
                setToAddressParameters()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    convenience init(textViewType: TextViewType) {
        self.init()
        
        self.textViewType = textViewType
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CustomTextView.CUSTOM_TEXT_VIEW_NIB, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    //MARK: - public methods
    func setType(_ textViewType: TextViewType) {
        self.textViewType = textViewType
    }
    
    //MARK: - private methods
    private func customizeViews() {
        if let type = textViewType {
            switch type {
            case .fromAddress:
                setFromAddressParameters()
            case .toAddress:
                setToAddressParameters()
            }
        }
    }
    
    private func setFromAddressParameters() {
        locationImage.tintColor = Colors.getColor(.buttonBlue)()
        verticalSplitterView.isHidden = true
        mapButton.isUserInteractionEnabled = false
        mapButton.setImage(UIImage(named: "visa"), for: .normal)
        indicatorView.backgroundColor = Colors.getColor(.buttonBlue)()
        texField.becomeFirstResponder()
    }
    
    private func setToAddressParameters() {
        if isTextFieldDisable {
            locationImage.tintColor = Colors.getColor(.disableGray)()
            mapButton.isUserInteractionEnabled = true
            mapButton.setImage(nil, for: .normal)
            mapButton.setTitle(TaxiOrderStrings.getString(.map)(), for: .normal)
            mapButton.setTitleColor(Colors.getColor(.textBlack)(), for: .normal)
            verticalSplitterView.isHidden = false
            indicatorView.backgroundColor = Colors.getColor(.disableGray)()
            texField.placeholder = TaxiOrderStrings.getString(.destinationPlaceholder)()
        } else {
            locationImage.tintColor = Colors.getColor(.locationOrange)()
            mapButton.isUserInteractionEnabled = true
            mapButton.setImage(nil, for: .normal)
            mapButton.setTitle(TaxiOrderStrings.getString(.map)(), for: .normal)
            mapButton.setTitleColor(Colors.getColor(.textBlack)(), for: .normal)
            verticalSplitterView.isHidden = false
            indicatorView.backgroundColor = Colors.getColor(.locationOrange)()
        }
    }
}

// MARK: - Extensions
extension CustomTextView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        switch textViewType {
        case .toAddress:
            if let text = texField.text {
                isTextFieldDisable = text.count > 0 ? false : true
            }
        default:
            break
        }
    }
}
