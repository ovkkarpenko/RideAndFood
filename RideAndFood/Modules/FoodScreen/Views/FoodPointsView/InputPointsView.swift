//
//  InputPointsView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class InputPointsView: CustomViewWithAnimation {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: CustomViewWithAnimation!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var confirmButton: CustomButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    weak var delegate: InputPointsViewDelegate?
    
    var pointsCount = 0
    
    static let INPUT_POINTS_VIEW = "InputPointsView"
    private let padding: CGFloat = 12.5
    
    private var isValidInput: Bool? {
        didSet {
            if isValidInput! {
                confirmButton.isEnabled = isValidInput!
                indicatorView.backgroundColor = Colors.buttonBlue.getColor()
            } else {
                confirmButton.isEnabled = isValidInput!
                indicatorView.backgroundColor = Colors.disableGray.getColor()
            }
        }
    }
    
    private var isErrorInput: Bool? {
        didSet {
            if isErrorInput! {
                indicatorView.backgroundColor = Colors.errorRed.getColor()
                errorLabel.isHidden = false
            } else {
                errorLabel.isHidden = true
            }
        }
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(InputPointsView.INPUT_POINTS_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    
        textField.delegate = self
        setKeyboardObserver()
        customizeSubviews()
        self.backgroundView.show() { [weak self] in
            self?.textField.becomeFirstResponder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    deinit {
        removeKeyboardObservation()
    }
    
    // MARK: - private methods
    private func customizeSubviews() {
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.cornerRadius = generalCornerRaduis
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        textField.placeholder = FoodStrings.enterPointsCount.text()
        
        confirmButton.customizeButton(type: .blueButton)
        confirmButton.setTitle(FoodStrings.confirm.text(), for: .normal)
        
        errorLabel.textColor = Colors.errorRed.getColor()
        errorLabel.text = FoodStrings.errorLabelMessage.text()
        errorLabel.isHidden = true
        
        isValidInput = false
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissAndRemoveFromParent))
        swipeGesture.direction = .down
        addGestureRecognizer(swipeGesture)
    }
    
    private func setKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardObservation() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        backgroundView.frame.origin.y = backgroundView.frame.origin.y - keyboardSize.height + padding
        
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        backgroundView.dismiss(padding: -(keyboardSize.height + padding))
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func dismissAndRemoveFromParent() {
        dismissKeyboard()
        dismiss() { [weak self] in
            self?.delegate?.cancelSwipeOccurred()
            self?.removeFromSuperview()
        }
    }
    
    @IBAction private func confirm(_ sender: Any) {
        dismissKeyboard()
        delegate?.confirmButtonPressed(enteredPointsCount: textField.text!)
        removeFromSuperview()
    }
}

extension InputPointsView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        checkIfInputMoreThenPointsCount()
    }
    
    private func checkIfInputMoreThenPointsCount() {
        if let input = textField.text, let intInput = Int(input) {
            isValidInput = intInput > pointsCount ? false : true
            isErrorInput = !isValidInput!
        } else {
            isValidInput = false
        }
    }
}
