//
//  ChangeCountView.swift
//  RideAndFood
//
//  Created by Laura Esaian on 21.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

enum ReservedChangeCount: Int {
    case change1000 = 1000
    case change5000 = 5000
}

class ChangeCountView: CustomViewWithAnimation {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var leftButton: CustomButton!
    @IBOutlet weak var rightButton: CustomButton!
    @IBOutlet weak var backgroundView: CustomViewWithAnimation!
    
    static let CHANGE_COUNT_VIEW = "ChangeCountView"
    
    weak var delegate: ChangeCountViewDelegate?
    
    private lazy var tapIndicator: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2
        view.backgroundColor = Colors.tapIndicatorOnDark.getColor()
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
        Bundle.main.loadNibNamed(ChangeCountView.CHANGE_COUNT_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        customizeView()
        
        backgroundView.show()
    }
    
    private func customizeView() {
        contentView.backgroundColor = Colors.tapIndicatorGray.getColor()
        
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.cornerRadius = generalCornerRaduis
        
        backgroundView.addSubview(tapIndicator)
        tapIndicator.heightAnchor.constraint(equalToConstant: 5).isActive = true
        tapIndicator.widthAnchor.constraint(equalToConstant: 40).isActive = true
        tapIndicator.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor).isActive = true
        tapIndicator.bottomAnchor.constraint(equalTo: backgroundView.topAnchor, constant: -10).isActive = true
        
        textLabel.text = FoodStrings.changeCount.text()
        
        leftButton.customizeButton(type: .greenButton)
        leftButton.setTitle(FoodStrings.leftChangeValue.text(), for: .normal)
        
        rightButton.customizeButton(type: .greenButton)
        rightButton.setTitle(FoodStrings.rightChangeValue.text(), for: .normal)
        
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismissFromParentView))
        swipeGesture.direction = .down
        addGestureRecognizer(swipeGesture)
    }
    
    @objc private func dismissFromParentView() {
        backgroundView.dismiss() { [weak self] in
            self?.removeFromSuperview()
        }
        
    }
    
    @IBAction func leftButtonTapped(_ sender: Any) {
        delegate?.changeCountSelected(count: ReservedChangeCount.change1000.rawValue)
        dismissFromParentView()
    }
    
    @IBAction func rightButtonTapped(_ sender: Any) {
        delegate?.changeCountSelected(count: ReservedChangeCount.change5000.rawValue)
        dismissFromParentView()
    }
}
