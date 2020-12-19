//
//  Double+Format.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 19.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

extension Double {
    func currencyString(currency: String = StringsHelper.rub.text()) -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f \(currency)", self)
        }
        
        return String(format: "%.2f \(currency)", self)
    }
}
