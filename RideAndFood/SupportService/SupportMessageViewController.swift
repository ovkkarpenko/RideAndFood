//
//  SupportMessageViewController.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 20.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class SupportMessageViewController: UIViewController {
    @IBOutlet weak var messageTextField: UITextView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonBottom: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeMessageTextField()
        customizeContinueButton()
        

//         call the 'keyboardWillShow' function when the view controller receive the notification that a keyboard is going to be shown
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

//           call the 'keyboardWillHide' function when the view controlelr receive notification that keyboard is going to be hidden
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func customizeMessageTextField() {
        messageTextField.layer.borderWidth = 1
        messageTextField.layer.borderColor = Colors.getColor(.borderGray)().cgColor
        messageTextField.layer.cornerRadius = CornerRadiuses.getRadius(.raduis15)()
    }
    
    private func customizeContinueButton() {
        continueButton.layer.cornerRadius = CornerRadiuses.getRadius(.raduis15)()
        continueButton.backgroundColor = Colors.getColor(.buttonBlue)()
        continueButton.setTitleColor(Colors.getColor(.buttonWhite)(), for: .normal)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        self.buttonBottom.constant = 25 + keyboardSize.height
        
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        
//        let selectedRange = messageTextField.selectedRange
//        messageTextField.scrollRangeToVisible(selectedRange)
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.buttonBottom.constant = 25

//        scrollView.contentInset = UIEdgeInsets.zero
//        let selectedRange = messageTextField.selectedRange
//        messageTextField.scrollRangeToVisible(selectedRange)
    }
}
