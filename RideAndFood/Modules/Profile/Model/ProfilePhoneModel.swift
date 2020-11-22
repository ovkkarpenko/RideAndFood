//
//  ProfilePhoneModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct ProfilePhoneModel {
    let id: Int
    var phone: String
    var formattedPhone: String {
        phone.formattedPhoneNumber()
    }
    let isMain: Bool
    
    init(id: Int, phone: String, isMain: Bool) {
        self.id = id
        self.phone = phone
        self.isMain = isMain
    }
    
    init(phone: Phone) {
        self.init(id: phone.id, phone: phone.phone, isMain: phone.main)
    }
}
