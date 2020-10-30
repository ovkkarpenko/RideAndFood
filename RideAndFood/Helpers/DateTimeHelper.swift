//
//  DateTimeHelper.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 30.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class DateTimeHelper {
    
    static let shared = DateTimeHelper()
    
    private init() { }
    
    func stringToDate(format: String, date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: date)
    }
}
