//
//  AccountTableViewCell.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 10.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AccountTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var leftView: UIView?
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leadingPadding: CGFloat = 25
    private let trailingPadding: CGFloat = 40
    private let padding: CGFloat = 13
    private let innerPadding: CGFloat = 7
    private lazy var labelLeadingConstraintWithLeftView: NSLayoutConstraint? = {
        if let leftView = leftView {
            return titleLabel.leadingAnchor.constraint(equalTo: leftView.trailingAnchor,
                                                       constant: innerPadding)
        }
        return nil
    }()
    private lazy var labelLeadingConstraintWithoutLeftView: NSLayoutConstraint =
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                            constant: leadingPadding)
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        descriptionLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        NSLayoutConstraint.activate([
            labelLeadingConstraintWithoutLeftView,
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(greaterThanOrEqualTo: titleLabel.trailingAnchor, constant: padding),
            descriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailingPadding)
        ])
        accessoryType = .disclosureIndicator
    }
    
    private func setupLeftView(view: UIView?) {
        leftView?.removeFromSuperview()
        leftView = view
        guard let view = view else {
            labelLeadingConstraintWithLeftView?.isActive = false
            labelLeadingConstraintWithoutLeftView.isActive = true
            return
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding),
            view.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            view.widthAnchor.constraint(equalTo: view.heightAnchor)
        ])
        labelLeadingConstraintWithoutLeftView.isActive = false
        labelLeadingConstraintWithLeftView?.isActive = true
    }
}

// MARK: - IConfigurableView

extension AccountTableViewCell: IConfigurableView {
    func configure(with model: AccountCellModel) {
        titleLabel.text = model.title
        descriptionLabel.text = model.description
        setupLeftView(view: model.leftView)
    }
}
