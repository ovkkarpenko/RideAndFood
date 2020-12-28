//
//  FoodPaymentModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 19.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class FoodPaymentModel {
    var sectionsCount = 2
    var deliveryCellTitle = FoodStrings.deliveryAddress.text()
    var paymentCellTitle = PaymentStrings.paymentTitle.text()
    var deliveryAddressCell: [DeliveryAddressCell]
    var foodPaymentCell: [FoodPaymentCell]
    
    struct DeliveryAddressCell {
        var address: String
        var addressName: String
    }
    
    struct FoodPaymentCell {
        var type: PaymentType
        var image: UIImage
        var text: NSAttributedString
        var isSelected = false
    }
    
    init(completion: (()->())? = nil) {
        self.deliveryAddressCell = [DeliveryAddressCell(address: "Address from db", addressName: "Address name from db")]
        self.foodPaymentCell = [
            FoodPaymentCell(type: .cash, image: UIImage(named: "cash")!, text: NSAttributedString(string: PaymentStrings.cash.text())),
            FoodPaymentCell(type: .applePay, image: UIImage(named: "applePay")!, text: NSAttributedString(string: PaymentStrings.applePay.text()))
        ]
        
        configureCardRow { [weak self] cardNumber in
            guard let self = self else { return }
            self.foodPaymentCell.insert(FoodPaymentCell(type: .card, image: UIImage(named: "visa")!, text: cardNumber), at: 1)
            completion?()
        }
    }
    
    private func configureCardRow(completion: @escaping (_ cardNumber: NSAttributedString) -> ()) {
        let request = RequestModel<PaymentCard>(path: paymentCardPath, method: .get)
        let networker = Networker()
        
        networker.makeRequest(request: request) { [weak self] (results: PaymentCard?, error: RequestErrorModel?) in
            guard let self = self else { return }
            if let results = results {
                completion(self.createAttributedCardNumber(number: results.number))
            }
            
            if let error = error {
                print(error.message)
            }
        }
    }
    
    private func createAttributedCardNumber(number: String) -> NSAttributedString {
        let text = NSMutableAttributedString(string: FoodStrings.card.text())
        text.append(NSAttributedString(string: " **** \(number.suffix(4))", attributes: [NSAttributedString.Key.foregroundColor : Colors.textGray.getColor()]))
        
        return text
    }
}
