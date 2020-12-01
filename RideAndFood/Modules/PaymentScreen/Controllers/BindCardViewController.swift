//
//  BindCardViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class BindCardViewController: UIViewController {
    
    var confirmCallback: (() -> ())?
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(named: "cardBackground", in: Bundle.init(path: "Images/PaymentScreen"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bindCardView: BindCardView = {
        let view = BindCardView()
        view.confirmCallback = { [weak self] cardDetails in
            guard let self = self else { return }
            
            self.confirmBindCardView.cardDetails = cardDetails
            
            self.toggleBindCardView(true)
            self.toggleConfirmBindCardView(false)
        }
        view.showErrorAlert = {
            AlertHelper.shared.alert(self, title: PaymentStrings.errorTitle.text(), message: PaymentStrings.errorDescription.text())
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confirmBindCardView: ConfirmBindCardView = {
        let view = ConfirmBindCardView()
        view.confirmCallback = { [weak self] in
            self?.confirmCallback?()
            self?.navigationController?.popViewController(animated: true)
        }
        view.cencelCallback = { [weak self] in
            self?.toggleConfirmBindCardView(true)
            self?.toggleBindCardView(false)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let padding: CGFloat = 20
    
    private lazy var bindCardViewBottomConstraint = bindCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    private lazy var bindCardViewHeightConstraint = bindCardView.heightAnchor.constraint(equalToConstant: 0)
    private lazy var confirmBindCardViewHeightConstraint = confirmBindCardView.heightAnchor.constraint(equalToConstant: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = PaymentStrings.bindCardTitle.text()
        navigationController?.navigationBar.topItem?.title = " "
        navigationController?.navigationBar.tintColor = .gray
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
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        toggleBindCardView(false)
    }
    
    func setupLayout() {
        view.addSubview(backgroundView)
        view.addSubview(backgroundImageView)
        view.addSubview(bindCardView)
        view.addSubview(confirmBindCardView)
        
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundView.rightAnchor.constraint(equalTo: view.rightAnchor),
            backgroundView.leftAnchor.constraint(equalTo: view.leftAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            
            bindCardViewHeightConstraint,
            bindCardViewBottomConstraint,
            bindCardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bindCardView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
            confirmBindCardViewHeightConstraint,
            confirmBindCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            confirmBindCardView.leftAnchor.constraint(equalTo: view.leftAnchor),
            confirmBindCardView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    private func toggleBindCardView(_ hide: Bool) {
        var animateOption: UIView.AnimationOptions = .curveEaseIn
        
        if hide {
            bindCardViewHeightConstraint.constant = 0
        } else {
            animateOption = .curveEaseOut
            bindCardViewHeightConstraint.constant = 220
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: ConstantsHelper.baseAnimationDuration.value(),
            options: animateOption) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    private func toggleConfirmBindCardView(_ hide: Bool) {
        var animateOption: UIView.AnimationOptions = .curveEaseIn
        
        if hide {
            confirmBindCardViewHeightConstraint.constant = 0
        } else {
            animateOption = .curveEaseOut
            confirmBindCardViewHeightConstraint.constant = 250
        }
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: ConstantsHelper.baseAnimationDuration.value(),
            options: animateOption) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        bindCardViewBottomConstraint.constant = -keyboardSize.height + view.safeAreaInsets.bottom
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        bindCardViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
}
