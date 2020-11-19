//
//  AddressTableViewCell.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = ColorHelper.secondaryText.color()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var homeIcom: UIImageView = {
        let image = UIImage(named: "home", in: Bundle.init(path: "Images/Icons"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let padding: CGFloat = 10
    private let paddingLeft: CGFloat = 50
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayout()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func setupLayout() {
        accessoryType = .disclosureIndicator
        
        addSubview(homeIcom)
        addSubview(nameLabel)
        addSubview(addressLabel)
        
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 55),
            
            homeIcom.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            homeIcom.centerYAnchor.constraint(equalTo: centerYAnchor),
            homeIcom.widthAnchor.constraint(equalToConstant: 14),
            homeIcom.heightAnchor.constraint(equalToConstant: 12),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeft),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeft),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
        ])
    }
}
