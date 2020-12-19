//
//  PointsView.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 15.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class PointsView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var spendAllPointsButton: CustomButton!
    @IBOutlet weak var spendSomePointsButton: UIButton!
    @IBOutlet weak var backgroundView: CustomViewWithAnimation!
    
    static let POINTS_VIEW = "PointsView"
    weak var delegate: PointsViewDelegate?
    var pointsCount: Int? {
        didSet {
            setPointsLabelText()
        }
    }
    
    fileprivate func initWithNib() {
        Bundle.main.loadNibNamed(PointsView.POINTS_VIEW, owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
        
        customizeSubviews()
        animateTransparentViewAppearance()
        self.backgroundView.show()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initWithNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initWithNib()
    }
    
    // MARK: - private methods
    private func customizeSubviews() {
        layer.cornerRadius = generalCornerRaduis
        
        backgroundView.layer.cornerRadius = generalCornerRaduis
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(dismiss))
        swipeGesture.direction = .down
        backgroundView.addGestureRecognizer(swipeGesture)
        
        spendAllPointsButton.customizeButton(type: .blueButton)
        spendAllPointsButton.setTitle(FoodStrings.spendAllPoints.text(), for: .normal)
        spendAllPointsButton.addTarget(self, action: #selector(spendAllPointsButtonTapped), for: .touchUpInside)
        
        spendSomePointsButton.setTitleColor(Colors.textBlack.getColor(), for: .normal)
        spendSomePointsButton.setTitle(FoodStrings.spendSomePoints.text(), for: .normal)
        spendSomePointsButton.addTarget(self, action: #selector(spendSomePointsButtonTapped), for: .touchUpInside)
    }
    
    private func animateTransparentViewAppearance() {
        UIView.animate(withDuration: generalAnimationDuration) { [weak self] in
            guard let self = self else { return }
            self.backgroundColor = Colors.tapIndicatorGray.getColor().withAlphaComponent(0.25)
        }
    }
    
    private func setPointsLabelText() {
        let text = NSMutableAttributedString(string: FoodStrings.youHave.text())
        if let pointsCount = pointsCount {
            text.append(NSAttributedString(string: PaymentStrings.pointsTitle("\(pointsCount)").text(), attributes: [NSAttributedString.Key.foregroundColor : Colors.yellow.getColor()]))
        }
        pointsLabel.attributedText = text
    }
    
    @objc private func spendSomePointsButtonTapped() {
        let inputPointsView = InputPointsView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: frame.height + UIApplication.shared.windows[0].safeAreaInsets.bottom))
        inputPointsView.delegate = self
        if let pointsCount = pointsCount {
            inputPointsView.pointsCount = pointsCount
        }
        
        backgroundView.dismiss()
        
        backgroundView.removeFromSuperview()
        
        addSubview(inputPointsView)
    }
    
    @objc private func spendAllPointsButtonTapped() {
        delegate?.spendAllPoints()
        removeFromSuperview()
    }
    
    @objc private func dismiss() {
        backgroundView.dismiss { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: generalAnimationDuration) {
                self.alpha = 0
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }
}

extension PointsView: InputPointsViewDelegate {
    func cancelSwipeOccurred() {
        removeFromSuperview()
    }
    
    func confirmButtonPressed(enteredPointsCount: String) {
        delegate?.setPointsToSpend(points: enteredPointsCount)
        removeFromSuperview()
    }
}
