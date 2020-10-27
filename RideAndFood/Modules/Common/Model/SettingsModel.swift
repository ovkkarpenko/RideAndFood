//
//  SettingsModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct SettingsModel: Codable {
    let language: Language
    let do_not_call: Bool
    let notification_discount: Bool
    let update_mobile_network: Bool
}
