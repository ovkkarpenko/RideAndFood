//
//  CencelTaxiOrderView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CencelTaxiOrderView: UIView, CustromViewProtocol {
    
    var dismissCallback: (() -> ())?
    
    private let cellIdentifier = "CencelTaxiOrderCell"
    private let reasons = [SelectTariffStrings.reason1.text(),
                           SelectTariffStrings.reason2.text(),
                           SelectTariffStrings.reason3.text(),
                           SelectTariffStrings.reason4.text()]
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = SelectTariffStrings.reasonTitle.text()
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private let padding: CGFloat = 20
    private let offset: CGFloat = UIScreen.main.bounds.height-300
    private let screenHeight = UIScreen.main.bounds.height
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    private func setupUI() {
        addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding),
        ])
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss(_ completion: (() -> ())?) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
}

extension CencelTaxiOrderView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dismiss { [weak self] in
            self?.removeFromSuperview()
        }
        
        dismissCallback?()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell.accessoryType = .disclosureIndicator
            cell.textLabel?.text = reasons[indexPath.row]
            cell.textLabel?.font = .systemFont(ofSize: 15)
            return cell
        }
        return .init()
    }
}
