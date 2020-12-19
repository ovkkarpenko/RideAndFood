//
//  ComplexButton.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 17.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ComplexButton: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var previousCostLabel: UILabel!
    @IBOutlet weak var newCostLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    static let COMPLEX_NUMBER = "ComplexButton"
    
//    init(previousCost: String, newCost: String) {
//        super.init(frame: CGRect())
//        initWithNib()
//        setPreviousCost(cost: previousCost)
//        setNewCost(text: newCost)
//    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    // MARK: - private methods
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(ComplexButton.COMPLEX_NUMBER, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        customizeSubviews()
    }
    
    private func customizeSubviews() {
        contentView.backgroundColor = Colors.buttonBlue.getColor()
        contentView.layer.cornerRadius = generalCornerRaduis
        
        leftLabel.text = FoodStrings.goToPayment.text()
        leftLabel.textColor = Colors.buttonWhite.getColor()
        
        previousCostLabel.textColor = Colors.buttonWhite.getColor()
        
        newCostLabel.textColor = Colors.buttonWhite.getColor()
        
        previousCostLabel.isHidden = true
    }
    
    // MARK: - public methods
    func setPreviousCost(cost: String) {
        let text = NSAttributedString(string: "\(cost) ", attributes: [NSAttributedString.Key.strikethroughStyle : 1])
        previousCostLabel.attributedText = text
        previousCostLabel.isHidden = false
    }
    
    func setNewCost(text: String) {
        newCostLabel.text = "\(text) "
    }
}
