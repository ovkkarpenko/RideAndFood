//
//  CustomTextView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 23.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation
//
//  CustomTextView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 10.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//
import UIKit

class CustomTextView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var locationButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var verticalSplitterView: UIView!
    
    static let CUSTOM_TEXT_VIEW_NIB = "CustomTextView"
    weak var customTextViewDelegate: CustomTextViewDelegate?
    
    var textViewType: TextViewType? {
        didSet {
            customizeViews()
        }
    }
    
    var isAddressListener = false
    
    private var isTextFieldEnable = false {
        didSet {
            if isTextFieldEnable != oldValue {
                customizeViews()
                if let textViewType = textViewType {
                    customTextViewDelegate?.isTextFieldFilled(state: isTextFieldEnable, senderType: textViewType)
                }
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
    func setTextViewType(_ textViewType: TextViewType) {
        self.textViewType = textViewType
    }
    
    func setText(_ text: String?) {
        if let text = text, text.count > 0 {
            textField.text = text
            isTextFieldEnable = true
        }
    }
    
    //MARK: - private methods
    private func customizeViews() {
        if let type = textViewType {
            switch type {
            case .currentAddress:
                setCurrentAddressParameters()
            case .destinationAddress:
                setDestinationAddressParameters()
            case .defaultBlue:
                setDefaultBlueParameters()
            case .defaultOrange:
                setDefaultOrangeParameters()
            }
        }
    }
    
    private func setDefaultBlueParameters() {
        indicatorView.backgroundColor = isTextFieldEnable ? Colors.getColor(.buttonBlue)() : Colors.getColor(.disableGray)()
    }
    
    private func setDefaultOrangeParameters() {
        indicatorView.backgroundColor = isTextFieldEnable ? Colors.getColor(.locationOrange)() : Colors.getColor(.disableGray)()
    }
    
    private func setCurrentAddressParameters() {
        verticalSplitterView.isHidden = true
        mapButton.isHidden = false
        mapButton.isUserInteractionEnabled = false
        mapButton.setImage(UIImage(named: "visa"), for: .normal)
        locationButton.isHidden = false
        
        if isTextFieldEnable {
            indicatorView.backgroundColor = Colors.getColor(.buttonBlue)()
            locationButton.tintColor = Colors.getColor(.buttonBlue)()
            locationButton.isUserInteractionEnabled = true
        } else {
            indicatorView.backgroundColor = Colors.getColor(.disableGray)()
            locationButton.tintColor = Colors.getColor(.disableGray)()
            locationButton.isUserInteractionEnabled = false
        }

    }
    
    private func setDestinationAddressParameters() {
        mapButton.isHidden = false
        mapButton.isUserInteractionEnabled = true
        mapButton.setImage(nil, for: .normal)
        mapButton.setTitle(TaxiOrderStrings.getString(.map)(), for: .normal)
        mapButton.setTitleColor(Colors.getColor(.textBlack)(), for: .normal)
        verticalSplitterView.isHidden = false
        locationButton.isHidden = false
        
        if isTextFieldEnable {
            locationButton.tintColor = Colors.getColor(.locationOrange)()
            locationButton.isUserInteractionEnabled = true
            indicatorView.backgroundColor = Colors.getColor(.locationOrange)()
        } else {
            locationButton.tintColor = Colors.getColor(.disableGray)()
            locationButton.isUserInteractionEnabled = false
            indicatorView.backgroundColor = Colors.getColor(.disableGray)()
            textField.placeholder = TaxiOrderStrings.getString(.destinationPlaceholder)()
        }
    }
    
    // MARK: - actions
    @IBAction func tapLocationButton(_ sender: Any) {
        if let type = textViewType {
            customTextViewDelegate?.locationButtonTapped(senderType: type)
        }
    }
    
    @IBAction func tapMapButton(_ sender: Any) {
        if let type = textViewType {
            customTextViewDelegate?.mapButtonTapped(senderType: type)
        }
    }
}

// MARK: - Extensions
extension CustomTextView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text {
            isTextFieldEnable = text.count > 0 ? true : false
            let state = text.count > 0 ? false : true
            customTextViewDelegate?.isDestinationAddressSelected(state: state)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textViewType {
        case .destinationAddress:
            customTextViewDelegate?.isDestinationAddressSelected(state: true)
        default:
            customTextViewDelegate?.isDestinationAddressSelected(state: false)
        }
    }
}
