//
//  TaxiConfirmationViewModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct TaxiConfirmationViewModel {
    let addressFrom: String
    let addressTo: String
    let primaryButtonPressedBlock: () -> Void
    let secondaryButtonPressedBlock: () -> Void
}
