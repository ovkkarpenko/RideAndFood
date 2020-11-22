//
//  PromoCodesCell.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 01.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PromoCodesTableViewCell: UITableViewCell {
    
    // MARK: - UI
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let leadingPadding: CGFloat = 25
    private let padding: CGFloat = 13
    
    // MARK: - Public properties
    
    var title: String? {
        didSet{
            titleLabel.text = title
        }
    }
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Lifecycle methods
    
    // MARK: - Private methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingPadding),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -padding)
        ])
        accessoryType = .disclosureIndicator
    }
}
