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
    }
    
    private func setupCurrentAddressDetail() {
        firstTextView.isHidden = false
        firstTextView.setTextViewType(.defaultBlue)
        firstTextView.textField.placeholder = TaxiOrderStrings.getString(.currentAddressDetailPlaceholder)()
        firstTextView.customTextViewDelegate = self

        button.setTitle(TaxiOrderStrings.getString(.confirm)(), for: .normal)
    }
    
    private func setupDestinationAddressDetail() {
        firstTextView.isHidden = false
        firstTextView.setTextViewType(.defaultOrange)
        firstTextView.textField.placeholder = TaxiOrderStrings.getString(.destinationAddressDetailPlaceholder)()
        firstTextView.customTextViewDelegate = self

        button.setTitle(TaxiOrderStrings.getString(.confirm)(), for: .normal)
    }
    
    private func setupOrderPriceView() {
        
    }
    
    private func setupConfirmationCode() {
        
    }
    
    private func setupDestinationAddressFromMap() {
        
    }
}
