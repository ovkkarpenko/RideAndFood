//
//  EnterPromoCodeViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class EnterPromoCodeViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "PromoCodeBG"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var promoCodeCardView: PromoCodeCardView = {
        let view = PromoCodeCardView()
        view.confirmBlock = { [weak self] code in
            self?.interactor.activatePromoCode(code: code) { (result, errorText) in
                guard let result = result, errorText == nil else {
                    DispatchQueue.main.async {
                        self?.promoCodeCardView.errorText = errorText
                    }
                    return
                }
                DispatchQueue.main.async {
                    let vc = PromoCodeActivatedViewController()
                    vc.descriptionText = result.description
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - Private properties
    
    private let interactor = PromoCodesInteractor()
    
    // MARK: - Lifecycle methods
    
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
        
        promoCodeCardView.focusTextView()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.secondaryBackground.color()
        view.addSubview(backgroundImageView)
        view.addSubview(promoCodeCardView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            promoCodeCardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            promoCodeCardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            promoCodeCardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationItem.title = PromoCodesStrings.enterPromoCode.text()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
            keyboardSize.height > 0 {
            
            promoCodeCardView.bottomPadding = keyboardSize.height - view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.view.layoutIfNeeded()
            }
        }
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        promoCodeCardView.bottomPadding = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
}
