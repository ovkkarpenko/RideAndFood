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
            break
        case .destinationAddressDetail:
            break
        case .orderPrice:
            setupOrderPriceView()
        case .confirmationCode:
            break
        case .destinationAddressFromMap:
            break
        }
    }
    
    private func setupAddressInputView() {
        firstTextView.isHidden = false
        secondTextView.isHidden = false
        
        firstTextView.setTextViewType(.fromAddress)
        secondTextView.setTextViewType(.toAddress)
        
        firstTextView.customTextViewDelegate = self
        secondTextView.customTextViewDelegate = self
        
        button.setTitle(TaxiOrderStrings.getString(.next)(), for: .normal)
        
        buttonAction = {
            let view = OrderViewDirector(type: .orderPrice)
            view.setCurrentAddress(address: self.currentAddress)
            return view
        }
    }
    
    private func setupOrderPriceView() {
        firstTextView.isHidden = false
        
        firstTextView.setTextViewType(.fromAddress)
        
        firstTextView.customTextViewDelegate = self
        
        button.setTitle(TaxiOrderStrings.getString(.next)(), for: .normal)
    }
}
