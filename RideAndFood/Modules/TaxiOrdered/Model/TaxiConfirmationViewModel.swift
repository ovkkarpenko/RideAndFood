//
//  TaxiConfirmationViewModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

struct TaxiConfirmationViewModel {
    let taxiOrderModel: OrderTaxiModel
    let primaryButtonPressedBlock: () -> Void
    let secondaryButtonPressedBlock: () -> Void
    var carName: String {
        "\(taxiOrderModel.color) \(taxiOrderModel.car)"
    }
    var tariffColor: UIColor? {
        switch taxiOrderModel.tariffId {
        case TariffId.premium.rawValue:
            return Colors.getColor(.tariffPurple)()
        case TariffId.business.rawValue:
            return Colors.getColor(.tariffGold)()
        default:
            return Colors.getColor(.tariffGreen)()
        }
    }
    var pickupTime: String {
        "\(Int.random(in: 1...25)) \(StringsHelper.minutes.text())"
    }
    var price: String {
        taxiOrderModel.price.currencyString()
    }
}
