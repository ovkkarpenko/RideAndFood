//
//  ProfileViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 10.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AccountBG"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.delegate = accountTableViewDelegate
        tableView.dataSource = accountTableViewDataSource
        tableView.backgroundColor = nil
        tableView.isScrollEnabled = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var cardView: CardView = {
        let view = CardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var dimmerView: DimmerView = {
        let view = DimmerView()
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmerPressed)))
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var phoneEnteringView: ProfilePhoneEnteringView = {
        let view = ProfilePhoneEnteringView()
        let model = ProfilePhoneEnteringViewModel { [weak self] phone in
            self?.confirmPhone(phone.onlyNumbers())
        }
        view.configure(with: model)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var codeConfirmationView: CodeConfirmationView {
        let view = CodeConfirmationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private let hideCardViewConstant: CGFloat = 200
    private lazy var cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                 constant: hideCardViewConstant)
    // MARK: - Private properties
    
    private let service: IProfileService = ProfileService()
    
    private var phones: [ProfilePhoneModel] = []
    private var cellId = "acoountCell"
    private lazy var accountTableViewDataSource = ProfileTableViewDataSource(cellId: cellId) { [weak self] in
        return self?.phones ?? []
    }
    private lazy var accountTableViewDelegate =
        ProfileTableViewDelegate(viewController: self,
                                 phoneNumberTappedBlock: { [weak self] row in
                                    self?.phoneNumberPressed(row: row)
                                 }, addressesTappedBlock: { [weak self] in
                                    self?.presentAddresesViewController()
                                 }, paymentHistoryTappedBlock: { [weak self] in
                                    self?.presentPaymentsHistoryViewController()
                                 }, ordersHistoryTappedBlock: { [weak self] in
                                    self?.presentOrdersHistoryViewController()
                                 },
                                 paymentsTappedBlock: { [weak self] in
                                    self?.presentPaymentsViewController()
                                 })
    
    private var isAddingMode = false
    private var actionId: Int?
    private var changePhoneModel: ProfilePhoneModel?
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
        loadData()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.secondaryBackground.color()
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
        view.addSubview(dimmerView)
        view.addSubview(cardView)
        NSLayoutConstraint.activate([
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            cardViewBottomConstraint,
            dimmerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmerView.topAnchor.constraint(equalTo: view.topAnchor),
            dimmerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorHelper.primaryText.color()
        navigationItem.title = ProfileStrings.title.text()
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "BackIcon"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(dismissSelf))
    }
    
    private func loadData() {
        service.getPhones { [weak self] (result) in
            self?.handlePhonesUpdated(result: result)
        }
    }
    
    private func handlePhonesUpdated(result: Result<[Phone], ServiceError>) {
        switch result {
        case .failure:
            showError()
        case .success(let phones):
            DispatchQueue.main.async { [weak self] in
                self?.updatePhones(phones: phones)
                self?.hideCardView()
            }
        }
    }
    
    private func handleCodeRecieved(result: Result<PhoneConfirmationCode, ServiceError>,
                                    resendCodePressedBlock: @escaping () -> Void) {
        switch result {
        case .failure:
            showError()
        case .success(let model):
            actionId = model.actionId
            if let code = model.code {
                DispatchQueue.main.async { [weak self] in
                    if let phone = self?.phones.first(where: { $0.isMain })?.formattedPhone {
                        self?.showCodeConfirmation(phone: phone, resendCodePressedBlock: resendCodePressedBlock)
                        AlertHelper().alert(self, title: "\(code)")
                    }
                }
            }
        }
    }
    
    private func showError() {
        DispatchQueue.main.async {
            AlertHelper().alert(self, title: StringsHelper.error.text(), message: StringsHelper.tryAgain.text())
        }
    }
    
    private func showCardView(completion: ((Bool) -> Void)? = nil) {
        dimmerView.show()
        guard cardViewBottomConstraint.constant > 0 else { return }
        cardViewBottomConstraint.constant = 0
        animateConstraints(completion: completion)
    }
    
    @objc private func hideCardView(completion: ((Bool) -> Void)? = nil) {
        cardViewBottomConstraint.constant = hideCardViewConstant
        dimmerView.hide()
        animateConstraints(completion: completion)
    }
    
    private func updateCardView(block: @escaping () -> Void, completion: (() -> Void)? = nil) {
        hideCardView { [weak self] _ in
            block()
            self?.view.layoutIfNeeded()
            self?.showCardView { _ in
                completion?()
            }
        }
    }
    
    private func animateConstraints(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func phoneNumberPressed(row: Int) {
        let contentView = ButtonsStackView()
        var buttonsStackViewModel: ButtonsStackViewModel
        if phones[row].isMain {
            buttonsStackViewModel = .init(primaryTitle: ProfileStrings.addPhoneNumber.text(),
                                          secondaryTitle: ProfileStrings.changePhoneNumber.text(),
                                          primaryButtonPressedBlock: { [weak self] in
                                            self?.isAddingMode = true
                                            self?.showPhoneEntering()
                                          },
                                          secondaryButtonPressedBlock: { [weak self] in
                                            self?.isAddingMode = false
                                            self?.changePhoneModel = self?.phones[row]
                                            self?.showPhoneEntering()
                                          })
        } else {
            buttonsStackViewModel = .init(primaryTitle: ProfileStrings.setAsDefault.text(),
                                          secondaryTitle: StringsHelper.delete.text(),
                                          primaryButtonPressedBlock: { [weak self] in
                                            if let phoneNumberModel = self?.phones[row] {
                                                self?.setPhoneAsMain(phoneModel: phoneNumberModel)
                                            }
                                          },
                                          secondaryButtonPressedBlock: {[weak self] in
                                            if let phoneNumberModel = self?.phones[row] {
                                                self?.deletePhone(phoneModel: phoneNumberModel)
                                            }
                                          })
        }
        contentView.configure(with: buttonsStackViewModel)
        cardView.configure(with: .init(contentView: contentView,
                                       style: .light,
                                       paddingBottom: 5,
                                       didSwipeDownCallback: { [weak self] in
                                        self?.hideCardView()
                                       }))
        view.layoutIfNeeded()
        showCardView()
    }
    
    private func showPhoneEntering() {
        phoneEnteringView.clearContent()
        updateCardView { [weak self] in
            guard let contentView = self?.phoneEnteringView else { return }
            self?.cardView.configure(with: .init(contentView: contentView,
                                                 style: .light,
                                                 paddingBottom: 25,
                                                 didSwipeDownCallback: { [weak self] in
                                                    self?.view.endEditing(false)
                                                 }))
        } completion: { [weak self] in
            self?.phoneEnteringView.focusTextView()
        }
    }
    
    private func showCodeConfirmation(phone: String, resendCodePressedBlock: @escaping () -> Void) {
        let codeConfirmationView = self.codeConfirmationView
        updateCardView { [weak self] in
            codeConfirmationView.configure(with: .init(phoneNumber: phone,
                                                       valueChangedBlock: { (isCompleted, code) in
                                                        if isCompleted, let code = code {
                                                            self?.confirmCode(code: code)
                                                        }
                                                       },
                                                       resendCodePressedBlock: resendCodePressedBlock))
            self?.cardView.configure(with: .init(contentView: codeConfirmationView,
                                                 style: .light,
                                                 paddingBottom: 15, didSwipeDownCallback: { [weak self] in
                                                    self?.view.endEditing(false)
                                                 }))
        } completion: {
            codeConfirmationView.focusTextField()
            codeConfirmationView.runTimer()
        }
    }
    
    private func setPhoneAsMain(phoneModel: ProfilePhoneModel) {
        service.changePhone(phone: .init(id: phoneModel.id,
                                         phone: phoneModel.phone,
                                         main: true)) { [weak self] result in
            self?.handleCodeRecieved(result: result) {
                self?.setPhoneAsMain(phoneModel: phoneModel)
            }
        }
    }
    
    private func deletePhone(phoneModel: ProfilePhoneModel) {
        service.deletePhone(id: phoneModel.id) { [weak self] result in
            self?.handlePhonesUpdated(result: result)
        }
        hideCardView()
    }
    
    private func confirmPhone(_ phone: String) {
        switch isAddingMode {
        case true:
            addPhone(phone)
        case false:
            if var model = changePhoneModel {
                model.phone = phone
                changePhone(model)
            }
        }
    }
    
    private func addPhone(_ phone: String) {
        service.addPhone(phone: phone) { [weak self] result in
            self?.handleCodeRecieved(result: result) { [weak self] in
                self?.addPhone(phone)
            }
        }
    }
    
    private func confirmCode(code: String) {
        guard let code = Int(code), let actionId = actionId else { return }
        service.confirmPhone(actionId: actionId, code: Int(code)) { [weak self] result in
            self?.handlePhonesUpdated(result: result)
        }
        hideCardView()
    }
    
    private func changePhone(_ phone: ProfilePhoneModel) {
        service.changePhone(phone: .init(id: phone.id, phone: phone.phone, main: phone.isMain)) { [weak self] result in
            self?.handleCodeRecieved(result: result) { [weak self] in
                self?.changePhone(phone)
            }
        }
    }
    
    private func updatePhones(phones: [Phone]) {
        self.phones = phones.map { ProfilePhoneModel(phone: $0) }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func presentAddresesViewController() {
        let vc = AddressesViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentPaymentsHistoryViewController() {
//        let vc = PaymentsHistoryViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentOrdersHistoryViewController() {
//        let vc = OrdersHistoryViewController()
//        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func presentPaymentsViewController() {
        let vc = PaymentViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
           keyboardSize.height > 0 {
            cardViewBottomConstraint.constant = -keyboardSize.height
            
            UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
                self.view.layoutIfNeeded()
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        cardViewBottomConstraint.constant = 0
        
        UIView.animate(withDuration: ConstantsHelper.baseAnimationDuration.value()) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func dimmerPressed() {
        cardViewBottomConstraint.constant = hideCardViewConstant
        dimmerView.hide()
        animateConstraints()
    }
}
