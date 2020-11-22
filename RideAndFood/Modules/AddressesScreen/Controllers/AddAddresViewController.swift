//
//  AddAddresViewController.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import MapKit

protocol RemoveAddressDelegate {
    func remove()
    func cencel()
}

class AddAddresViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: 420)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var backgroundAlertView: UIView = {
        let view = UIView()
        
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(backgroundSwipe))
        swipe.direction = .down
        view.addGestureRecognizer(swipe)
        
        view.backgroundColor = .black
        view.alpha = 0
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var addressView: AddressView = {
        let view = AddressView()
        view.showMapButtonCallback = { [weak self] in
            let vc = SelectAddressMapViewController()
            vc.addressCallback = { address in
                view.setAddress(address)
            }
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var deliveryAddressTitleView: UIView = {
        let view = DeliveryAddressTitleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var deliveryAddressView: DeliveryAddressView = {
        let view = DeliveryAddressView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [addressView, deliveryAddressTitleView, deliveryAddressView])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = PrimaryButton(title: AddAddressesStrings.saveButton.text())
        button.addTarget(self, action: #selector(saveAddressButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var chooseDestinationButton: UIButton = {
        address?.destination = true
        
        let button = PrimaryButton(title: AddAddressesStrings.chooseDestination.text())
        button.isHidden = true
        button.addTarget(self, action: #selector(saveAddressButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var removeButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        button.isHidden = true
        button.setTitle(AddAddressesStrings.removeButton.text(), for: .normal)
        button.setTitleColor(ColorHelper.primaryText.color(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.addTarget(self, action: #selector(removeAddressButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var removeAddressView: UIView = {
        let view = RemoveAddressView()
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = AddAddressesStrings.title.text()
        setupLayout()
        initView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        saveAddressButtonPressed()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if touches.first?.view == backgroundAlertView {
            toggleRemoveAddressView(true)
        }
    }
    
    var address: Address?
    
    private let padding: CGFloat = 20
    
    private lazy var scrollViewBottonConstraint = scrollView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
    private lazy var removeAddressViewHeightConstraint = removeAddressView.heightAnchor.constraint(equalToConstant: 0)
    
    func setupLayout() {
        scrollView.addSubview(backgroundView)
        scrollView.addSubview(stackView)
        scrollView.addSubview(saveButton)
        scrollView.addSubview(chooseDestinationButton)
        scrollView.addSubview(removeButton)
        view.addSubview(scrollView)
        view.addSubview(backgroundAlertView)
        view.addSubview(removeAddressView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollViewBottonConstraint,
            
            removeAddressViewHeightConstraint,
            removeAddressView.leftAnchor.constraint(equalTo: view.leftAnchor),
            removeAddressView.rightAnchor.constraint(equalTo: view.rightAnchor),
            removeAddressView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundAlertView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundAlertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundAlertView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundAlertView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: padding),
            
            addressView.heightAnchor.constraint(equalToConstant: 130),
            deliveryAddressTitleView.heightAnchor.constraint(equalToConstant: 45),
            deliveryAddressView.heightAnchor.constraint(equalToConstant: 130),
            
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            saveButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            
            chooseDestinationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            chooseDestinationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            chooseDestinationButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: padding),
            
            removeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            removeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            removeButton.topAnchor.constraint(equalTo: chooseDestinationButton.bottomAnchor, constant: padding)
        ])
    }
    
    func initView() {
        guard let address = address else { return }
        
        saveButton.isHidden = true
        chooseDestinationButton.isHidden = false
        removeButton.isHidden = false
        
        addressView.addressNameTextField.text = address.name
        addressView.addressTextField.text = address.address
        addressView.commentForDriverTextField.text = address.commentDriver
        
        deliveryAddressView.apartmentTextField.text = address.flat == 0 ? "" : "\(address.flat)"
        deliveryAddressView.commentForCourierTextField.text = address.commentCourier
        deliveryAddressView.doorphoneTextField.text = address.intercom == 0 ? "" : "\(address.intercom)"
        deliveryAddressView.entranceTextField.text = address.entrance == 0 ? "" : "\(address.entrance)"
        deliveryAddressView.floorTextField.text = address.floor == 0 ? "" : "\(address.floor)"
    }
    
    func toggleRemoveAddressView(_ hide: Bool) {
        var animateOption: UIView.AnimationOptions = .curveEaseIn
        
        if hide {
            removeAddressViewHeightConstraint.constant = 0
        } else {
            animateOption = .curveEaseOut
            removeAddressViewHeightConstraint.constant = 200
        }
        
        backgroundAlertView.isHidden = hide
        navigationController?.setNavigationBarHidden(!hide, animated: true)
        
        UIView.animate(
            withDuration: ConstantsHelper.baseAnimationDuration.value(),
            delay: 0,
            options: animateOption, animations: { [weak self] in
                self?.backgroundAlertView.alpha = hide ? 0 : 0.3
                self?.view.layoutIfNeeded()
            })
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            
            scrollViewBottonConstraint.constant = -keyboardSize.height - view.safeAreaInsets.bottom
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        scrollViewBottonConstraint.constant = -padding
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func saveAddressButtonPressed() {
        let addressInputs = addressView.getUserInputs()
        let deliveryAddressInputs = deliveryAddressView.getUserInputs()
        
        if addressInputs.0.isEmpty || addressInputs.1.isEmpty {
            AlertHelper.shared.alert(self, title: StringsHelper.alertErrorTitle.text(), message: StringsHelper.alertErrorDescription.text())
            return
        }
        
        DispatchQueue.main.async {
            self.saveButton.isEnabled = false
        }
        
        if let address = self.address {
            let updatedAddress = Address(id: address.id, name: addressInputs.0, address: addressInputs.1, commentDriver: addressInputs.2, commentCourier: deliveryAddressInputs.4, flat: deliveryAddressInputs.0, intercom: deliveryAddressInputs.1, entrance: deliveryAddressInputs.2, floor: deliveryAddressInputs.3, destination: address.destination)
            
            ServerApi.shared.updateAddress(updatedAddress, completion: { [weak self] _, error in
                guard let self = self else { return }
                
                if error == nil {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.saveButton.isEnabled = true
                    }
                    AlertHelper.shared.alert(self, title: StringsHelper.alertErrorTitle.text(), message: StringsHelper.alertErrorDescription.text())
                }
            })
        } else {
            let savedAddress = Address(id: self.address != nil ? self.address!.id : nil, name: addressInputs.0, address: addressInputs.1, commentDriver: addressInputs.2, commentCourier: deliveryAddressInputs.4, flat: deliveryAddressInputs.0, intercom: deliveryAddressInputs.1, entrance: deliveryAddressInputs.2, floor: deliveryAddressInputs.3)
            
            ServerApi.shared.saveAddress(savedAddress, completion: { [weak self] _, error in
                guard let self = self else { return }
                
                if error == nil {
                    DispatchQueue.main.async {
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    self.saveButton.isEnabled = true
                    AlertHelper.shared.alert(self, title: StringsHelper.alertErrorTitle.text(), message: StringsHelper.alertErrorDescription.text())
                }
            })
        }
    }
    
    @objc private func removeAddressButtonPressed() {
        toggleRemoveAddressView(false)
    }
    
    @objc private func backgroundSwipe() {
        toggleRemoveAddressView(true)
    }
}

extension AddAddresViewController: RemoveAddressDelegate {
    
    func remove() {
        if let address = address {
            ServerApi.shared.deleteAddress(address, completion: { [weak self] _, error in
                guard let self = self else { return }
                
                if error == nil {
                    DispatchQueue.main.async {
                        self.toggleRemoveAddressView(true)
                        self.navigationController?.popViewController(animated: true)
                    }
                } else {
                    AlertHelper.shared.alert(self, title: StringsHelper.alertErrorTitle.text(), message: StringsHelper.alertErrorDescription.text())
                }
            })
        }
    }
    
    func cencel() {
        toggleRemoveAddressView(true)
    }
}
