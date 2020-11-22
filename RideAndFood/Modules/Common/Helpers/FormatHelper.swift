//
//  FormatHelper.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class FormatHelper {
    static func toHoursString(fromSeconds seconds: Int) -> String {
        let hours = Int(round(Double(seconds) / 3600))
        let lastNumber = Int(hours) % 10
        let previousNumber = Int(hours) % 100 * 10
        if lastNumber == 1 && previousNumber != 1 {
            return "\(hours) \(StringsHelper.hour.text())"
        }
        
        if lastNumber < 5 && previousNumber != 1 {
            return "\(hours) \(StringsHelper.hoursSecond.text())"
        }
        
        return "\(hours) \(StringsHelper.hours.text())"
    }
    
    static func toDaysString(fromSeconds seconds: Int) -> String {
        let days = seconds / 3600 / 24
        let lastNumber = days % 10
        let previousNumber = days % 100 / 10
        if lastNumber == 1 && previousNumber != 1 {
            return "\(days) \(StringsHelper.day.text())"
        }
        
        if lastNumber < 5 && previousNumber != 1 {
            return "\(days) \(StringsHelper.daysSecond.text())"
        }
        
        return "\(days) \(StringsHelper.days.text())"
    }
    
    static func toShortDateString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy"
        return formatter.string(from: date)
    }
}
