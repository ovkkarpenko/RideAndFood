//
//  ActiveOrderView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 04.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ActiveOrderView: UIView
{
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var firstTextLabel: UILabel!
    @IBOutlet weak var secondTextLabel: UILabel!
    @IBOutlet weak var taxiMiniCarImageView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var strokeImageView: UIImageView!
    @IBOutlet weak var firstLabelImage: UIImageView!
    @IBOutlet weak var secondLabelImage: UIImageView!
    
    static let ORDER_VIEW = "ActiveOrderView"
    var activeOrderViewType: ActiveOrderViewType? {
        didSet {
            customizeActiveOrderView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(ActiveOrderView.ORDER_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    convenience init(type: ActiveOrderViewType) {
        self.init()
        self.activeOrderViewType = type
    }
    
    private func customizeActiveOrderView() {
        if let type = activeOrderViewType {
            switch type {
            case .taxiActiveOrderView:
                customizeTaxiActiveOrderView()
            case .foodActiveOrderView:
                customizeFoodActiveOrderView()
            }
        }
    }
    
    private func customizeTaxiActiveOrderView() {
        strokeImageView.image = UIImage(named: CustomImagesNames.stroke.rawValue)
        
        firstLabelImage.image = UIImage(named: CustomImagesNames.mark.rawValue)
        firstLabelImage.tintColor = Colors.getColor(.buttonBlue)()
        
        secondLabelImage.image = UIImage(named: CustomImagesNames.mark.rawValue)
        secondLabelImage.tintColor = Colors.getColor(.locationOrange)()
        
        taxiMiniCarImageView.isHidden = false
    }
    
    private func customizeFoodActiveOrderView() {
        strokeImageView.image = UIImage(named: CustomImagesNames.reversedStroke.rawValue)
        
        firstLabelImage.image = UIImage(named: CustomImagesNames.bag.rawValue)
        
        secondLabelImage.image = UIImage(named: CustomImagesNames.mark.rawValue)
        secondLabelImage.tintColor = Colors.getColor(.buttonBlue)()
        
        taxiMiniCarImageView.isHidden = true
    }
}
