//
//  BindCardViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class BindCardViewController: UIViewController {
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let image = UIImage(named: "background2", in: Bundle.init(path: "Images/PaymentScreen"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var bindCardView: BindCardView = {
        let view = BindCardView()
        view.confirmCallback = { [weak self] in
            self?.toggleBindCardView(true)
            self?.toggleConfirmBindCardView(false)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var confirmBindCardView: ConfirmBindCardView = {
        let view = ConfirmBindCardView()
        view.confirmCallback = { [weak self] in
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
    
    private lazy var confirmButtonBottomConstraint = bindCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
            confirmButtonBottomConstraint,
            
            bindCardViewHeightConstraint,
            bindCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
            bindCardViewHeightConstraint.constant = 200
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.3,
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
            confirmBindCardViewHeightConstraint.constant = 230
        }
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.3,
            options: animateOption) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            
            confirmButtonBottomConstraint.constant = -keyboardSize.height + view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        confirmButtonBottomConstraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
}
