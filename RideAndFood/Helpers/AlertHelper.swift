//
//  AlertHelper.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 28.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

class AlertHelper {
    
    static let shared = AlertHelper()
    
    func alert(_ vc: UIViewController, title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            vc.present(alert, animated: true)
        }
    }
    
    func alert(_ vc: UIViewController?, title: String, message: String? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        vc?.present(alert, animated: true)
    }
}
