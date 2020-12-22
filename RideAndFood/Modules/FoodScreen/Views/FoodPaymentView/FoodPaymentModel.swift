//
//  FoodPaymentModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 19.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

struct FoodPaymentModel {
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
        var text: String
        var isSelected = false
    }
    
    init() {
        self.deliveryAddressCell = [DeliveryAddressCell(address: "Address from db", addressName: "Address name from db")]
        self.foodPaymentCell = [FoodPaymentCell(type: .cash, image: UIImage(named: "cash")!, text: PaymentStrings.cash.text()),
                                FoodPaymentCell(type: .card, image: UIImage(named: "card")!, text: PaymentStrings.card.text()),
                                FoodPaymentCell(type: .applePay, image: UIImage(named: "applePay")!, text: PaymentStrings.applePay.text())]
    }
}
