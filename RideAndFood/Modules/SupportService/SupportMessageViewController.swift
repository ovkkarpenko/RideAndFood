//
//  SupportMessageViewController.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 20.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class SupportMessageViewController: UIViewController {
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var continueButton: CustomButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonBottom: NSLayoutConstraint!
    
    private let padding: CGFloat = 25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageTextView.delegate = self
        
        customizeMessageTextView()
        customizeContinueButton()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func customizeMessageTextView() {
        messageTextView.layer.borderWidth = 1
        messageTextView.layer.borderColor = Colors.getColor(.borderGray)().cgColor
        messageTextView.layer.cornerRadius = generalCornerRaduis
        messageTextView.textColor = Colors.getColor(.textGray)()
        messageTextView.text = SupportServiceString.getString(.problemDescription)()
    }
    
    private func customizeContinueButton() {
        continueButton.customizeButton(type: .blueButton)
        continueButton.isEnabled = false
        continueButton.setTitle(SupportServiceString.getString(.continueButton)(), for: .normal)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }

        self.buttonBottom.constant = padding + keyboardSize.height
        
//        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//        let selectedRange = messageTextField.selectedRange
//        messageTextField.scrollRangeToVisible(selectedRange)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        self.buttonBottom.constant = padding

//        scrollView.contentInset = UIEdgeInsets.zero
//        let selectedRange = messageTextField.selectedRange
//        messageTextField.scrollRangeToVisible(selectedRange)
    }
}

// MARK: - Extensions
extension SupportMessageViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        continueButton.isEnabled = !(messageTextView.text?.isEmpty ?? false)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == Colors.getColor(.textGray)() {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
}
