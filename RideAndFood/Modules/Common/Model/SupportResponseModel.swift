//
//  SupportResponseModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct SupportResponseModel: Codable {
    var message: String?
    var images: [MediaResponseModel?]?
}
