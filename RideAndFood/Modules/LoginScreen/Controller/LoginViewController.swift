//
//  LoginViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 19.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var loginView: LoginView = {
        let view = LoginView(frame: .zero)
        view.valueChangedCallback = { [weak self] isCompleted in
            self?.confirmButton.isEnabled = isCompleted
        }
        
        view.termsOfUsePressedCallback = { [weak self] in
            let vc = TermsOfUseViewController()
            let nc = UINavigationController(rootViewController: vc)
            self?.present(nc, animated: true)
        }
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private lazy var confirmButton = PrimaryButton(title: StringsHelper.next.text())
    private lazy var confirmButtonBottomConstraint = confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                                           constant: -padding)
    private let padding: CGFloat = 25
    
    // MARK: - UIViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginView.focusTextView()
    }

    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.background.color()
        view.addSubview(loginView)
        view.addSubview(confirmButton)
        
        let loginViewCenterYConstraint = loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            loginView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: padding * 2),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            loginView.bottomAnchor.constraint(lessThanOrEqualTo: confirmButton.topAnchor, constant: -padding),
            loginViewCenterYConstraint,
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            confirmButtonBottomConstraint
        ])
        loginViewCenterYConstraint.priority = .defaultLow
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            keyboardSize.height > 0 {
            
            confirmButtonBottomConstraint.constant = -keyboardSize.height - padding + view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {

        confirmButtonBottomConstraint.constant = -padding
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
}

