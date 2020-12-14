//
//  CarNumberView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 13.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CarNumberView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var regionNumberLabel: UILabel!
    
    static let CAR_NUMBER_VIEW = "CarNumberView"
    
    var number: String? {
        didSet {
            numberLabel.text = number
        }
    }
    var regionNumber: String? {
        didSet {
            regionNumberLabel.text = regionNumber
        }
    }
    
    init(number: String, regionNumber: String) {
        self.number = number
        self.regionNumber = regionNumber
        super.init(frame: CGRect())
        initWithNib()
        numberLabel.text = number
        regionNumberLabel.text = regionNumber
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func layoutSubviews() {
        customizeSubviews()
    }
    
    // MARK: - private methods

    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(CarNumberView.CAR_NUMBER_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func customizeSubviews() {
        backgroundView.backgroundColor = Colors.getColor(.carNumberGray)()
        
        regionNumberLabel.textColor = Colors.getColor(.textGray)()
    }
    
}
