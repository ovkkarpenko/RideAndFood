//
//  PromoCodesListViewController.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 04.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodesListViewController: UIViewController {
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PromoCodeCardCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var segmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [PromoCodesStrings.active.text(),
                                                 PromoCodesStrings.inactive.text()])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(updateData), for: .valueChanged)
        control.setTitleTextAttributes([.font : FontHelper.regular15.font() as Any], for: .normal)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var noCodesLabel: UILabel = {
        let label = UILabel()
        label.text = PromoCodesStrings.noPromoCodes.text()
        label.textColor = ColorHelper.secondaryText.color()
        label.alpha = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Private properties
    
    private let cellId = "promoCodeCell"
    
    private var currentModels: [PromoCodeCellModel] {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            return activePromoCodes
        case 1:
            return inactivePromoCodes
        default:
            return []
        }
    }
    private var activePromoCodes: [PromoCodeCellModel] = []
    private var inactivePromoCodes: [PromoCodeCellModel] = []
    private let interactor = PromoCodesInteractor()
    private let padding: CGFloat = 25
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        loadData()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        navigationItem.title = PromoCodesStrings.promoCodesHistory.text()
        view.backgroundColor = ColorHelper.secondaryBackground.color()
        view.addSubview(segmentControl)
        view.addSubview(tableView)
        view.addSubview(noCodesLabel)
        
        NSLayoutConstraint.activate([
            segmentControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding / 2),
            segmentControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: padding / 2),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noCodesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noCodesLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            noCodesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            noCodesLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
    
    private func loadData() {
        interactor.getPromoCodes() { [weak self] (promoCodes, errorText) in
            guard let promoCodes = promoCodes, errorText == nil else { return }
            let models = promoCodes.map { PromoCodeCellModel(promoCode: $0) }
            self?.activePromoCodes = models.filter { $0.isActive }
            self?.inactivePromoCodes = models.filter { !$0.isActive }
            DispatchQueue.main.async {
                self?.updateData()
            }
        }
    }
    
    @objc private func updateData() {
        tableView.reloadData()
        if currentModels.isEmpty {
            tableView.alpha = 0
            noCodesLabel.alpha = 1
        } else {
            tableView.alpha = 1
            noCodesLabel.alpha = 0
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PromoCodesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? PromoCodeCardCell
        else { return UITableViewCell() }
        
        cell.model = currentModels[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135.5
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard segmentControl.selectedSegmentIndex == 0 else { return UIView(frame: .zero) }
        let view = UIView()
        let label = UILabel()
        label.text = PromoCodesStrings.disclaimer.text()
        label.font = FontHelper.regular12.font()
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        view.addSubview(label)
        view.backgroundColor = ColorHelper.background.color()
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            label.topAnchor.constraint(equalTo: view.topAnchor),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            label.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        return view
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        if segmentControl.selectedSegmentIndex == 0 {
            return 56
        } else {
            return 0
        }
    }
}
