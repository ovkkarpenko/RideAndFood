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
    @IBOutlet weak var timeLabel: InsetLabel!
    @IBOutlet weak var strokeImageView: UIImageView!
    @IBOutlet weak var firstLabelImage: UIImageView!
    @IBOutlet weak var secondLabelImage: UIImageView!
    
    static let ACTIVE_ORDER_VIEW = "ActiveOrderView"
    
    var activeOrderViewType: ActiveOrderViewType
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(ActiveOrderView.ACTIVE_ORDER_VIEW, owner: self, options: nil)
        addSubview(contentView)
    }
    
    init(type: ActiveOrderViewType) {
        self.activeOrderViewType = type
        super.init(frame: CGRect())
        
        initWithNib()
        customizeActiveOrderView()
    }
    
    private func customizeActiveOrderView() {
        switch activeOrderViewType {
        case .taxiActiveOrderView:
            customizeTaxiActiveOrderView()
        case .foodActiveOrderView:
            customizeFoodActiveOrderView()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func customizeTaxiActiveOrderView() {
        firstTextLabel.textColor = Colors.getColor(.textGray)()
        
        secondTextLabel.textColor = Colors.getColor(.textGray)()
        
        strokeImageView.image = UIImage(named: CustomImagesNames.stroke.rawValue)
        
        firstLabelImage.image = UIImage(named: CustomImagesNames.mark.rawValue)
        
        secondLabelImage.image = UIImage(named: CustomImagesNames.orangeMark.rawValue)
        
        timeLabel.backgroundColor = Colors.getColor(.backgroundGray)()
        
        taxiMiniCarImageView.isHidden = false
    }
    
    private func customizeFoodActiveOrderView() {
        firstTextLabel.textColor = Colors.getColor(.textGray)()
        
        secondTextLabel.textColor = Colors.getColor(.textGray)()
        
        strokeImageView.image = UIImage(named: CustomImagesNames.reversedStroke.rawValue)
        
        firstLabelImage.image = UIImage(named: CustomImagesNames.bag.rawValue)
        
        secondLabelImage.image = UIImage(named: CustomImagesNames.mark.rawValue)
        
        timeLabel.backgroundColor = Colors.getColor(.backgroundGray)()
        
        taxiMiniCarImageView.isHidden = true
    }
}
