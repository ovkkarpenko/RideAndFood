//
//  TaxiActiveOrderView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 06.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TaxiActiveOrderView: CustomViewWithAnimation {
    private lazy var activeOrderView: ActiveOrderView = {
        let view = ActiveOrderView(type: .taxiActiveOrderView)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var tapIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 2
        view.backgroundColor = Colors.getColor(.tapIndicatorGray)()
        return view
    }()
    
    private var padding: CGFloat = 25
    
    private var sidePadding: CGFloat = 10
    
    var isLastView = false {
        didSet {
            if isLastView {
                addSubview(tapIndicator)
                
                NSLayoutConstraint.activate([tapIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                                             tapIndicator.bottomAnchor.constraint(equalTo: topAnchor, constant: -sidePadding),
                                             tapIndicator.heightAnchor.constraint(equalToConstant: 5),
                                             tapIndicator.widthAnchor.constraint(equalToConstant: 40)])
            } else {
                tapIndicator.removeFromSuperview()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addShadow()
    }
    
    // MARK: - private methods
    private func addShadow() {
        layer.masksToBounds = false
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = generalCornerRaduis
        backgroundColor = Colors.getColor(.buttonWhite)()
        layer.shadowColor = Colors.getColor(.shadowColor)().cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: -10)
        layer.shadowRadius = generalCornerRaduis
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    private func setupLayout() {
        self.addSubview(activeOrderView)
        
        NSLayoutConstraint.activate([activeOrderView.topAnchor.constraint(equalTo: topAnchor, constant: padding), activeOrderView.leadingAnchor.constraint(equalTo: leadingAnchor), activeOrderView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: sidePadding), activeOrderView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: padding)])
        
//        addGestures() 
    }
    
//    private func addGestures() {
//        let dismissGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
//        dismissGesture.direction = .down
//        addGestureRecognizer(dismissGesture)
//    }
    
    // MARK: - public methods
    func setFromAddress(address: String?) {
        activeOrderView.firstTextLabel.text = address
    }
    
    func setToAddress(address: String?) {
        activeOrderView.secondTextLabel.text = address
    }
    
    func setDeliveryTime(value: Int) {
        let text = NSMutableAttributedString(string: ActiveTaxiOrderStrings.getString(.deliveryTime)())
        text.append(NSAttributedString(string: "≈ \(value) мин", attributes: [NSAttributedString.Key.foregroundColor : Colors.getColor(.locationOrange)()]))
        
        activeOrderView.timeLabel.attributedText = text
    }
}
