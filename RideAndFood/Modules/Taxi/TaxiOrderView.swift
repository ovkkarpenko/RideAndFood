//
//  TaxiOrderView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 12.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
class TaxiOrderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var firstTextView: CustomTextView!
    @IBOutlet var secondTextView: CustomTextView!
    @IBOutlet weak var additionalViewContainer: UIView!
    @IBOutlet var button: CustomButton!
    @IBOutlet weak var tapIndicator: UIView!
    @IBOutlet weak var panelView: UIView!
    
    private var input: Int!
    static let TAXI_ORDER_VIEW = "TaxiOrderView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    convenience init(input: Int) {
        self.init()
        self.input = input // temporary
        
        button.customizeButton(type: .blueButton)
        customizeTapIndicator()
        customizePanelView()
        
        firstTextView.setTextViewType(.fromAddress)
        secondTextView.setTextViewType(.toAddress)
        secondTextView.customTextViewDelegate = self
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(TaxiOrderView.TAXI_ORDER_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    private func customizeTapIndicator() {
        tapIndicator.layer.cornerRadius = 2
        tapIndicator.backgroundColor = Colors.getColor(.tapIndicatorGray)()
    }
    
    private func customizePanelView() {
        let cornerRadius: CGFloat = 20
        
        panelView.layer.masksToBounds = false
        panelView.layer.cornerRadius = cornerRadius
        panelView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        panelView.backgroundColor = Colors.getColor(.buttonWhite)()
        panelView.layer.shadowColor = Colors.getColor(.shadowColor)().cgColor
        panelView.layer.shadowOpacity = 1
        panelView.layer.shadowOffset = CGSize(width: 0, height: -10)
        panelView.layer.shadowRadius = cornerRadius
        panelView.layer.shadowPath = UIBezierPath(rect: panelView.bounds).cgPath
        panelView.layer.shouldRasterize = true
        panelView.layer.rasterizationScale = UIScreen.main.scale
    }
    
}

extension TaxiOrderView: CustomTextViewDelegate {
    func checkIfDestinationAddressAvailable(state: Bool) {
        self.additionalViewContainer.isHidden = !state
    }
}
