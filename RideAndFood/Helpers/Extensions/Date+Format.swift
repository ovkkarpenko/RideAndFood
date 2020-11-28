//
//  Date+Format.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 24.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

extension Date {
    func fullFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM, HH:MM"
        return dateFormatter.string(from: self)
    }
}
