//
//  Float+Format.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 08.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

extension Float {
    func currencyString(currency: String = StringsHelper.rub.text()) -> String {
        if self.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f \(currency)", self)
        }
        
        return String(format: "%.2f \(currency)", self)
    }
}
