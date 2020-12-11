//
//  NotificationModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

struct NotificationModel {
    let messageText: String
    let iconImage: UIImage?
    let closeBlock: (() -> Void)?
    let tappedBlock: (() -> Void)?
}
