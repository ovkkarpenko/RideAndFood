//
//  AddressCell.swift
//  RideAndFood
//
//  Created by Laura Esaian on 22.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {
    @IBOutlet var cell: UITableViewCell!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    static let ADDRESS_CELL = "AddressCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(AddressCell.ADDRESS_CELL, owner: self, options: nil)
        cell.frame = bounds
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.selectionStyle = .none
        selectionStyle = .none
        addSubview(cell)
    }
}
