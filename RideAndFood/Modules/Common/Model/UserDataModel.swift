//
//  UserDataModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct UserDataModel: Codable {
    let id: Int
    let name: String?
    let email: String?
    let created_at: Date
    let updated_at: Date?
    let deleted_at: Date?
    let setting: SettingsModel
}
