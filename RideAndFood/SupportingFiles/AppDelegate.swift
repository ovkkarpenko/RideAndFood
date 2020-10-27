//
//  AppDelegate.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 19.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Public properties
    
    var window: UIWindow?

    // MARK: - App lifecycle methods
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
//        let rootVc = LoginViewController()
        let rootVc = ViewController()
        
        window = UIWindow()
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        return true
    }
}
