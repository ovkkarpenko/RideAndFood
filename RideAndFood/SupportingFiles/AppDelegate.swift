//
//  AppDelegate.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 28.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootVc = MapViewController()
        
        #if DEBUG
        if CommandLine.arguments.contains("enable-testing") {
            configureAppForTesting()
        }
        #endif
        
        window = UIWindow()
        window?.rootViewController = rootVc
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureAppForTesting() {
        UserConfig.shared.userId = 0
    }
}
