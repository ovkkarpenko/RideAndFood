//
//  AccountViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 10.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "AccountBG"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(AccountTableViewCell.self, forCellReuseIdentifier: cellId)
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
    
    private lazy var phoneEnteringView: AccountPhoneEnteringView = {
        let view = AccountPhoneEnteringView()
        let model = AccountPhoneEnteringViewModel { [weak self] phoneNumber in
            self?.confirmPhoneNumber(phoneNumber)
        }
        view.configure(with: model)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var codeConfirmationView: CodeConfirmationView = {
        let view = CodeConfirmationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let hideCardViewConstant: CGFloat = 200
    private lazy var cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                 constant: hideCardViewConstant)
    
    // MARK: - Private properties
    
    var phoneNumbers: [PhoneNumberModel] = [.init(formattedPhone: "9995555555".formattedPhoneNumber(), isDefault: true),
                                            .init(formattedPhone: "9993333333".formattedPhoneNumber(), isDefault: false)]
    var cellId = "acoountCell"
    private lazy var accountTableViewDataSource = AccountTableViewDataSource(phoneNumbers: phoneNumbers, cellId: cellId)
    private lazy var accountTableViewDelegate = AccountTableViewDelegate(viewController: self) { [weak self] row in
        self?.phoneNumberPressed(row: row)
    }
    
    private var isAddingMode = false
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
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
    
    // MARK: - Private methods
    
    private func setupLayout() {
        view.backgroundColor = ColorHelper.secondaryBackground.color()
        view.addSubview(backgroundImageView)
        view.addSubview(tableView)
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
            cardViewBottomConstraint
        ])
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = ColorHelper.primaryText.color()
        navigationItem.title = AccountStrings.title.text()
        navigationItem.leftBarButtonItem = .init(image: UIImage(named: "BackIcon"),
                                                 style: .done,
                                                 target: self,
                                                 action: #selector(dismissSelf))
    }
    
    private func showCardView(completion: ((Bool) -> Void)? = nil) {
        guard cardViewBottomConstraint.constant > 0 else { return }
        cardViewBottomConstraint.constant = 0
        animateConstraints(completion: completion)
    }
    
    private func hideCardView(completion: ((Bool) -> Void)? = nil) {
        cardViewBottomConstraint.constant = hideCardViewConstant
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
        if phoneNumbers[row].isDefault {
            buttonsStackViewModel = .init(primaryTitle: AccountStrings.addPhoneNumber.text(),
                                          secondaryTitle: AccountStrings.changePhoneNumber.text(),
                                          primaryButtonPressedBlock: { [weak self] in
                                            self?.isAddingMode = true
                                            self?.showPhoneEntering()
                                          },
                                          secondaryButtonPressedBlock: {[weak self] in
                                            self?.isAddingMode = false
                                            self?.showPhoneEntering()
                                          })
        } else {
            buttonsStackViewModel = .init(primaryTitle: AccountStrings.setAsDefault.text(),
                                          secondaryTitle: StringsHelper.delete.text(),
                                          primaryButtonPressedBlock: { [weak self] in
                                            if let phoneNumberModel = self?.phoneNumbers[row] {
                                                self?.setPhoneAsDefault(phoneModel: phoneNumberModel)
                                            }
                                          },
                                          secondaryButtonPressedBlock: {[weak self] in
                                            if let phoneNumberModel = self?.phoneNumbers[row] {
                                                self?.deletePhone(phoneModel: phoneNumberModel)
                                            }
                                          })
        }
        contentView.configure(with: buttonsStackViewModel)
        cardView.configure(with: .init(contentView: contentView,
                                             paddingBottom: 5,
                                             didSwipeDownCallback: { [weak self] in
            self?.hideCardView()
        }))
        view.layoutIfNeeded()
        showCardView()
    }
    
    private func showPhoneEntering() {
        updateCardView { [weak self] in
            guard let contentView = self?.phoneEnteringView else { return }
            self?.cardView.configure(with: .init(contentView: contentView,
                                                 paddingBottom: 25,
                                                 didSwipeDownCallback: { [weak self] in
                                                    self?.view.endEditing(false)
                                                 }))
        } completion: { [weak self] in
            self?.phoneEnteringView.focusTextView()
        }
    }
    
    private func setPhoneAsDefault(phoneModel: PhoneNumberModel) {
        print(#function)
    }
    
    private func deletePhone(phoneModel: PhoneNumberModel) {
        hideCardView()
    }
    
    private func confirmPhoneNumber(_ phoneNumber: String?) {
        updateCardView { [weak self] in
            guard let codeConfirmationView = self?.codeConfirmationView else { return }
            codeConfirmationView.configure(with: .init(phoneNumber: phoneNumber,
                                                       valueChangedBlock: { (isCompleted, code) in
                                                        print("valueChangedBlock", isCompleted, code!)
                                                       },
                                                       resendCodePressedBlock: {
                                                        print("resendCodePressedBlock")
                                                       }))
            self?.cardView.configure(with: .init(contentView: codeConfirmationView,
                                                 paddingBottom: 15, didSwipeDownCallback: { [weak self] in
                                                    self?.view.endEditing(false)
                                                 }))
        } completion: { [weak self] in
            self?.codeConfirmationView.focusTextField()
            self?.codeConfirmationView.runTimer()
        }
        
        print(phoneNumber?.onlyNumbers() ?? #function)
    }
    
    private func confirmCode(code: String) {
        print(code)
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
}
