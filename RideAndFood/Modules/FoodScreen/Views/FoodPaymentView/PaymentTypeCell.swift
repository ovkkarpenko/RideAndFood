//
//  PaymentTypeCell.swift
//  RideAndFood
//
//  Created by Laura Esaian on 20.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PaymentTypeCell: UITableViewCell {
    @IBOutlet var cell: UITableViewCell!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var cellTextLabel: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    
    static let PAYMENT_TYPE_CELL = "PaymentTypeCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    private func initWithNib() {
        Bundle.main.loadNibNamed(PaymentTypeCell.PAYMENT_TYPE_CELL, owner: self, options: nil)
        cell.frame = bounds
        cell.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cell.selectionStyle = .none
        selectionStyle = .none
        addSubview(cell)
    }
}
