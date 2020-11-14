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
    
    private lazy var codeConfirmationView: CodeConfirmationView = {
        let view = CodeConfirmationView()
        view.valueChangedCallback = { [weak self] isCompleted in
            self?.confirmButton.isEnabled = isCompleted
        }
        view.resendCodePressedCallback = { [weak self] in
            self?.getConfirmationCode(showConfirmationView: false)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var codeLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = ColorHelper.primary.color()
        label.textColor = ColorHelper.primaryButtonText.color()
        label.textAlignment = .center
        label.isHidden = true
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton = PrimaryButton(title: StringsHelper.next.text())
    private let padding: CGFloat = 25
    
    // MARK: - Constraints
    
    private lazy var loginViewLeadingConstraint = loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding)
    private lazy var loginViewTrailingConstraint = loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
    private lazy var loginViewTempTrailingConstraint = loginView.trailingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                                           constant: -padding)
    private lazy var codeViewCenterXConstraint = codeConfirmationView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    private lazy var codeViewLeadingConstraint = codeConfirmationView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                                                               constant: padding)
    private lazy var codeViewTrailingConstraint = codeConfirmationView.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                                                 constant: -padding)
    private lazy var codeViewTempLeadingConstraint = codeConfirmationView.leadingAnchor.constraint(equalTo: view.trailingAnchor,
                                                                                                   constant: padding)
    private lazy var confirmButtonBottomConstraint = confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                                                           constant: -padding)
    
    // MARK: - Private properties
    
    private var interactor = LoginInteractor()
    private var phone: String?
    private var code: String?
    
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
        view.addSubview(codeConfirmationView)
        view.addSubview(confirmButton)
        view.addSubview(codeLabel)
        
        let loginViewCenterYConstraint = loginView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: padding * 2),
            loginView.bottomAnchor.constraint(lessThanOrEqualTo: confirmButton.topAnchor, constant: -padding),
            loginViewLeadingConstraint,
            loginViewTrailingConstraint,
            loginViewCenterYConstraint,
            codeViewTempLeadingConstraint,
            codeConfirmationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            codeConfirmationView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -padding),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            confirmButtonBottomConstraint,
            codeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            codeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            codeLabel.widthAnchor.constraint(equalToConstant: 60)
        ])
        loginViewCenterYConstraint.priority = .defaultLow
        
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    
    private func showCodeConfirmationView() {
        loginViewLeadingConstraint.isActive = false
        loginViewTrailingConstraint.isActive = false
        loginViewTempTrailingConstraint.isActive = true
        codeViewTempLeadingConstraint.isActive = false
        codeViewLeadingConstraint.isActive = true
        codeViewTrailingConstraint.isActive = true
        codeViewCenterXConstraint.isActive = true
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
        confirmButton.isEnabled = false
        codeConfirmationView.focusTextField()
        codeConfirmationView.runTimer()
        codeConfirmationView.phoneNumberString = loginView.phoneNumberString
    }
    
    private func getConfirmationCode(showConfirmationView: Bool = true) {
        guard let phone = phone else {
            return
        }
        
        interactor.getCode(for: phone) { [weak self] (codeModel, error) in
            guard let codeModel = codeModel, error == nil else {
                self?.showErrorAlert(message: LoginStrings.errorText.text())
                return
            }
            
            DispatchQueue.main.async {
                self?.codeLabel.text = "\(codeModel.code)"
                self?.codeLabel.isHidden = false
                if showConfirmationView {
                    self?.showCodeConfirmationView()
                }
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        DispatchQueue.main.async {
            AlertHelper.shared.alert(self, title: LoginStrings.errorTitle.text(), message: message)
        }
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
    
    @objc private func confirmButtonPressed() {
        confirmButton.isEnabled = false
        if let code = codeConfirmationView.code, !code.isEmpty, let phone = phone, !phone.isEmpty {
            interactor.confirmCode(forPhone: phone, code: code) { [weak self] (userData, error) in
                guard let userData = userData, error == nil else {
                    self?.showErrorAlert(message: LoginStrings.wrongCode.text())
                    return
                }
                
                UserConfig.shared.userId = userData.id
                UserConfig.shared.phoneNumber = self?.loginView.phoneNumberString ?? ""
                
                DispatchQueue.main.async {
                    self?.dismiss(animated: true)
                }
            }
        } else if let phone = loginView.phoneNumberString?.components(separatedBy: CharacterSet.decimalDigits.inverted)
                    .joined() {
            self.phone = phone
            getConfirmationCode()
        }
    }
}

