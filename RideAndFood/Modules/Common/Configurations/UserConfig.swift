//
//  UserConfig.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

class UserConfig {
    
    // MARK: - Singleton
    
    static let shared = UserConfig()
    private init() { }
    
    // MARK: - Private properties
    
    private let userIdKey = "userId"
    
    // MARK: - Public properties
    
    var userId: Int {
        get {
            UserDefaults.standard.integer(forKey: userIdKey)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: userIdKey)
        }
    }
}

// TODO: Store language in UserDefaults

let language = "rus"
