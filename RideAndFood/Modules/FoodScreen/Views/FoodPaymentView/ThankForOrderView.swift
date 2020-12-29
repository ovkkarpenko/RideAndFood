//
//  ThankForOrderView.swift
//  RideAndFood
//
//  Created by Laura Esaian on 27.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ThankForOrderView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var backgroundView: CustomViewWithAnimation!
    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var button: CustomButton!
    
    static let THANK_FOR_ORDER_VIEW = "ThankForOrderView"
    
    private lazy var tapIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.tapIndicatorGray.getColor()
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(ThankForOrderView.THANK_FOR_ORDER_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        customizeView()
        
        backgroundView.show()
    }
    
    // MARK: - private methods
    private func customizeView() {
        backgroundView.addSubview(tapIndicator)
        tapIndicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        tapIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tapIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        tapIndicator.bottomAnchor.constraint(equalTo: backgroundView.topAnchor, constant: -10).isActive = true
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(buttonTapped))
        swipeGesture.direction = .down
        backgroundView.addGestureRecognizer(swipeGesture)

        addShadow()
        
        firstLabel.text = FoodStrings.thanks.text()
        firstLabel.textColor = Colors.buttonGreen.getColor()
        firstLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        secondLabel.text = FoodStrings.gladToSeeAgain.text()
        secondLabel.textColor = Colors.textGray.getColor()

        button.customizeButton(type: .blueButton)
        button.setTitle(FoodStrings.newOrder.text(), for: .normal)
    }
    
    private func addShadow() {
        backgroundView.layer.masksToBounds = false
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.cornerRadius = generalCornerRaduis
        backgroundView.backgroundColor = Colors.getColor(.buttonWhite)()
        backgroundView.layer.shadowColor = Colors.getColor(.shadowColor)().cgColor
        backgroundView.layer.shadowOpacity = 1
        backgroundView.layer.shadowOffset = CGSize(width: 0, height: -10)
        backgroundView.layer.shadowRadius = generalCornerRaduis
        backgroundView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        backgroundView.layer.shouldRasterize = true
        backgroundView.layer.rasterizationScale = UIScreen.main.scale
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        backgroundView.dismiss() { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
}

