//
//  ButtonsStackViewModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ButtonsStackViewModel {
    let primaryTitle: String
    let secondaryTitle: String
    let primaryButtonPressedBlock: () -> Void
    let secondaryButtonPressedBlock: () -> Void
}
