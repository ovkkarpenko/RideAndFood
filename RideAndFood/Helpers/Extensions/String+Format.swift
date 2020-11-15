//
//  String+Format.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 10.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

extension String {
    func formattedPhoneNumber(code: String = "7") -> String {
        guard !self.isEmpty else { return self }
        var numbers = Array(self)
        if numbers[0] == "8" {
            numbers[0] = "7"
        } else if numbers[0] == "9" && code != "9" {
            numbers.insert(contentsOf: code, at: 0)
        } else if numbers[0] == "+" {
            numbers.remove(at: 0)
        }
        
        guard numbers.count > 10 else { return "+\(numbers[0]) \(String(numbers.suffix(from: 1)))"}
        
        let operatorCode = String([numbers[1], numbers[2], numbers[3]])
        let firstSection = String([numbers[4], numbers[5], numbers[6]])
        let moddleSection = String([numbers[7], numbers[8]])
        let lastSection = String(numbers.suffix(from: 9))
                        
        
        return "+\(numbers[0]) (\(operatorCode)) \(firstSection)-\(moddleSection)-\(lastSection)"
    }
    
    func onlyNumbers() -> String {
        return self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    }
}
