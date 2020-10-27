//
//  CodeConfirmationModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CodeConfirmationModel: Codable {
    let phone: String
    let code: String
}
