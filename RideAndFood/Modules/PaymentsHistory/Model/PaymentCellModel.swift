//
//  PaymentCellModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 23.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

struct PaymentCellModel {
    let paymentNumber: Int
    let amount: Double
    let cardNumber: String?
    let method: String
    let paymentSystem: String?
    let service: String
    let date: Date
    
    var cardImage: UIImage? {
        switch method {
        case "cash":
            return UIImage(named: "cash")
        case "card":
            switch paymentSystem {
            case "MasterCard":
                return UIImage(named: "MasterCardLogo")
            case "Visa":
                return UIImage(named: "VisaLogo")
            default:
                return nil
            }
        default:
            return nil
        }
    }
    
    var paymentTitle: String {
        return "\(PaymentsHistoryStrings.payment.text()) № \(paymentNumber)"
    }
    
    var amountText: String {
        return "\(amount) \(PaymentsHistoryStrings.rub.text())"
    }
    
    var descriptionText: String {
        return "\(date.fullFormat()) / \(service)"
    }
    
    var detailText: String {
        return PaymentsHistoryStrings.description.text()
    }
    
    init?(payment: Payment) {
        guard let paymentNumber = payment.order,
              let paid = payment.paid,
              let method = payment.method else {
            return nil
        }
        
        self.paymentNumber = paymentNumber
        self.amount = paid
        self.method = method
        self.cardNumber = payment.paymentCard?.number
        self.paymentSystem = payment.paymentCard?.system
        self.service = paid.truncatingRemainder(dividingBy: 2) == 0 ? PaymentsHistoryStrings.taxi.text() : PaymentsHistoryStrings.food.text()
        self.date = Date()
    }
}
