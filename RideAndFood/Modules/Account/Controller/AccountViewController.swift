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
    
    private let hideCardViewConstant: CGFloat = 500
    private lazy var cardViewBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                                                 constant: hideCardViewConstant)
    
    // MARK: - Private properties
    
    var phoneNumbers: [PhoneNumberModel] = [.init(formattedPhone: "9995555555".formattedPhoneNumber(), isDefault: true),
                                            .init(formattedPhone: "9993333333".formattedPhoneNumber(), isDefault: false)]
    var cellId = "acoountCell"
    private lazy var accountTableViewDataSource = AccountTableViewDataSource(phoneNumbers: phoneNumbers, cellId: cellId)
    private lazy var accountTableViewDelegate = AccountTableViewDelegate(viewController: self) { [weak self] row in
        
    }
    
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupLayout()
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
    
    private func showCardView() {
        cardViewBottomConstraint.constant = 0
        animateConstraints()
    }
    
    private func hideCardView() {
        cardViewBottomConstraint.constant = hideCardViewConstant
        animateConstraints()
    }
    
    private func animateConstraints() {
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true)
    }
}
