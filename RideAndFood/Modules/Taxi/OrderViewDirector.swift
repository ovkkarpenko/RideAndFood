//
//  OrderViewDirector.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class OrderViewDirector: OrderView {
    var type: OrderViewType?
    
    convenience init(type: OrderViewType) {
        self.init()
        self.type = type
        
        switch type {
        case .addressInput:
            setupAddressInputView()
            getSavedAddresses()
        case .currentAddressDetail:
            setupCurrentAddressDetail()
        case .destinationAddressDetail:
            setupDestinationAddressDetail()
        case .orderPrice:
            setupOrderPriceView()
        case .confirmationCode:
            setupConfirmationCode()
        case .destinationAddressFromMap:
            setupDestinationAddressFromMap()
        }
    }
    
    private func setupAddressInputView() {
        firstTextView.isHidden = false
        secondTextView.isHidden = false
        
        firstTextView.setTextViewType(.currentAddress)
        secondTextView.setTextViewType(.destinationAddress)
        
        firstTextView.customTextViewDelegate = self
        secondTextView.customTextViewDelegate = self
        
        button.setTitle(TaxiOrderStrings.getString(.next)(), for: .normal)
        
        buttonAction = {
            let view = OrderViewDirector(type: .currentAddressDetail)
//            view.setCurrentAddress(address: self.currentAddress)
            return view
        }
        
        firstTextView.textField.becomeFirstResponder()
    }
    
    private func setupCurrentAddressDetail() {
        firstTextView.isHidden = false
        firstTextView.setTextViewType(.defaultBlue)
        firstTextView.textField.placeholder = TaxiOrderStrings.getString(.currentAddressDetailPlaceholder)()
        firstTextView.customTextViewDelegate = self
        
        addressLabelPanelView.isHidden = false
        labelImage.tintColor = Colors.getColor(.buttonBlue)()
        addressLabel.text = currentAddress

        button.setTitle(TaxiOrderStrings.getString(.confirm)(), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            guard let self = self else { return }
            self.firstTextView.textField.becomeFirstResponder()
        }
    }
    
    private func setupDestinationAddressDetail() {
        firstTextView.isHidden = false
        firstTextView.setTextViewType(.defaultOrange)
        firstTextView.textField.placeholder = TaxiOrderStrings.getString(.destinationAddressDetailPlaceholder)()
        firstTextView.customTextViewDelegate = self
        
        addressLabelPanelView.isHidden = false
        labelImage.tintColor = Colors.getColor(.locationOrange)()
        addressLabel.text = currentAddress

        button.setTitle(TaxiOrderStrings.getString(.confirm)(), for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            guard let self = self else { return }
            self.firstTextView.textField.becomeFirstResponder()
        }
    }
    
    private func setupOrderPriceView() {
        
    }
    
    private func setupConfirmationCode() {
        
    }
    
    private func setupDestinationAddressFromMap() {
        
    }
}
