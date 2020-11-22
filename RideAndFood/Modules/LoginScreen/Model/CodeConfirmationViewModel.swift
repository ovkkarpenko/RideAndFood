//
//  CodeConfirmationView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 15.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CodeConfirmationViewModel {
    let phoneNumber: String?
    let valueChangedBlock: ((Bool, String?) -> Void)?
    let resendCodePressedBlock: (() -> Void)?
}
