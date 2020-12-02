//
//  AlertTextFieldViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class AlertTextFieldViewController: UIViewController {
    
    @IBOutlet weak var button: AlertButton!
    @IBOutlet weak var textField: AlertTextField!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertHeightConstraint: NSLayoutConstraint!
    
    private let padding: CGFloat = 160
    
    let bag = DisposeBag()
    
    var buttonTitle: String?
    var textFieldValue: String?
    var placeholder: String?
    var buttonClickedCallback: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAlert()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first?.view != alertView {
            dismiss(animated: true)
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        UIView.animate(withDuration: 0.6) { [weak self] in
            guard let self = self else { return }
            self.alertHeightConstraint.constant = self.padding + keyboardSize.height - self.view.safeAreaInsets.bottom
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        UIView.animate(withDuration: 0.6) { [weak self] in
            guard let self = self else { return }
            self.alertHeightConstraint.constant = self.padding
            self.view.layoutIfNeeded()
        }
    }
    
    func setupAlert() {
        button.setTitle(buttonTitle ?? "", for: .normal)
        textField.text = textFieldValue ?? ""
        textField.placeholder = placeholder ?? ""
        alertView.layer.cornerRadius = 20
        
        textField.rx
            .controlEvent(.editingChanged)
            .withLatestFrom(textField.rx.text.orEmpty)
            .subscribe(onNext: { [weak self] text in
                self?.button.buttonState = !text.isEmpty
            }).disposed(by: bag)
        
        button.rx
            .controlEvent(.touchUpInside)
            .withLatestFrom(textField.rx.value)
            .subscribe(onNext: { [weak self] text in
                guard let self = self else { return }
                if let text = text {
                    self.buttonClickedCallback?(text)
                }
                self.dismiss(animated: true)
            }).disposed(by: bag)
    }
}
