//
//  BaseUserDefaultsManager.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class BaseUserDefaultsManager: UserDefaultsManager {
    
    var isAuthorized: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isAuthorized")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isAuthorized")
        }
    }
}
