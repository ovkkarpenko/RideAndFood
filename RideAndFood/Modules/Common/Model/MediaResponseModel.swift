//
//  MediaResponseModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct MediaResponseModel: Codable {
    var fileName: String?
    var mimeType: String?
    var url: String?
    var size: Int?
    var createdAt: Int?
    var updatedAt: Int?
    
    private enum CodingKeys: String, CodingKey {
        case fileName = "file_name"
        case mimeType = "mime_type"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
