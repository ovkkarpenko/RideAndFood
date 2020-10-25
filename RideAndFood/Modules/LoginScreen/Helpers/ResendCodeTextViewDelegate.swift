//
//  ResendCodeTextViewDelegate.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ResendCodeTextViewDelegate: NSObject, UITextViewDelegate {
    
    // MARK: - Public properties
    
    var pressedCallback: (() -> Void)?
    
    // MARK: - UITextViewDelegate
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "resendCode" {
            if let pressedCallback = pressedCallback {
                pressedCallback()
            }
            return false
        }
        else {
            return true
        }
    }
}
