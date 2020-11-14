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
    private let userPhoneNumber = "phoneNumber"
    private let settingsLanguageKey = "settingsLanguageKey"
    private let settingsDoNotCallKey = "settingsDoNotCallKey"
    private let settingsNotificationDiscountKey = "settingsNotificationDiscountKey"
    private let settingsUpdateMobileNetworkKey = "settingsUpdateMobileNetworkKey"
    
    // MARK: - Public properties
    
    var userId: Int {
        get {
            UserDefaults.standard.integer(forKey: userIdKey)
        } set {
            UserDefaults.standard.setValue(newValue, forKey: userIdKey)
        }
    }
    
    var phoneNumber: String {
        get {
            UserDefaults.standard.string(forKey: userPhoneNumber) ?? ""
        } set {
            UserDefaults.standard.setValue(newValue, forKey: userPhoneNumber)
        }
    }
    
    var settings: Settings {
        get {
            var settings = Settings()
            settings.language = Language(rawValue: UserDefaults.standard.value(forKey: settingsLanguageKey) as? String ?? "rus") ?? Language.rus
            settings.doNotCall = UserDefaults.standard.value(forKey: settingsDoNotCallKey) as? Bool ?? false
            settings.notificationDiscount = UserDefaults.standard.value(forKey: settingsNotificationDiscountKey) as? Bool ?? false
            settings.updateMobileNetwork = UserDefaults.standard.value(forKey: settingsUpdateMobileNetworkKey) as? Bool ?? false
            
            return settings
        } set {
            UserDefaults.standard.setValue(newValue.language.rawValue, forKey: settingsLanguageKey)
            UserDefaults.standard.setValue(newValue.doNotCall, forKey: settingsDoNotCallKey)
            UserDefaults.standard.setValue(newValue.notificationDiscount, forKey: settingsNotificationDiscountKey)
            UserDefaults.standard.setValue(newValue.updateMobileNetwork, forKey: settingsUpdateMobileNetworkKey)
        }
    }
}
