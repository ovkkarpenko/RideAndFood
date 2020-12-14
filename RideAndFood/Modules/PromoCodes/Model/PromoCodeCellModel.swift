//
//  PromoCodeCellModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

struct PromoCodeCellModel {
    private var promoCode: PromoCode
    
    var expireDate: Date
    var isActive: Bool
    var icon: UIImage?
    var statusDescription: String
    var statusTime: String
    var code: String
    var title: String
    var sale: Int
    var saleText: String
    
    init(promoCode: PromoCode) {
        self.promoCode = promoCode
        expireDate = promoCode.dateActivation.addingTimeInterval(TimeInterval(promoCode.validity))
        isActive = expireDate.timeIntervalSinceNow > 0
        code = promoCode.code
        title = promoCode.shortDescription
        
        var imageName: String
        if isActive {
            imageName = "PromoCodeWaiting"
            statusDescription = PromoCodesStrings.expiresIn.text()
            if expireDate.timeIntervalSinceNow / 3600 / 24 >= 1 {
                statusTime = FormatHelper.toDaysString(fromSeconds: Int(expireDate.timeIntervalSinceNow))
            } else {
                statusTime = FormatHelper.toHoursString(fromSeconds: Int(expireDate.timeIntervalSinceNow))
            }
        } else if promoCode.used {
            imageName = "PromocodeSuccess"
            statusDescription = PromoCodesStrings.promoCodeActivated.text()
            statusTime = FormatHelper.toShortDateString(date: expireDate)
        } else {
            imageName = "PromocodeExpired"
            statusDescription = PromoCodesStrings.promoCodeHasExpired.text()
            statusTime = FormatHelper.toShortDateString(date: expireDate)
        }
        icon = UIImage(named: imageName)
        saleText = "-\(promoCode.sale)%"
        sale = promoCode.sale
    }
}
