//
//  TariffPointsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class TariffPointsView: UIView, CustromViewProtocol {
    
    var dismissCallback: ((Int?) -> ())?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorHelper.background.color()
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var transparentView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pointsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = PaymentStrings.pointsFullTitle("0").text()
        label.font = .systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var confirmButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.spendAllPoints.text())
        button.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var otherQuantityButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.otherQuantity.text())
        button.addTarget(self, action: #selector(otherQuantityButtonPressed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var otherQuantityPointsView: OtherQuantityPointsView = {
        let view = OtherQuantityPointsView()
        view.maxPoints = points
        view.dismissCallback = { [weak self] points in
            self?.dismiss { [weak self] in
                self?.dismissCallback?(points)
                self?.removeFromSuperview()
            }
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if touches.first?.view == transparentView {
            dismiss { [weak self] in
                self?.removeFromSuperview()
            }
        }
    }
    
    private let padding: CGFloat = 20
    private let offset: CGFloat = UIScreen.main.bounds.height-200
    private let screenHeight = UIScreen.main.bounds.height
    
    private var points: Int?
    private let viewModel = SelectTariffViewModel()
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    
    private func setupUI() {
        addSubview(transparentView)
        addSubview(contentView)
        contentView.addSubview(pointsLabel)
        contentView.addSubview(confirmButton)
        contentView.addSubview(otherQuantityButton)
        
        NSLayoutConstraint.activate([
            transparentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            transparentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            transparentView.topAnchor.constraint(equalTo: topAnchor),
            transparentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            pointsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            pointsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            pointsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            confirmButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            confirmButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            confirmButton.topAnchor.constraint(equalTo: pointsLabel.bottomAnchor, constant: padding),
            
            otherQuantityButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            otherQuantityButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            otherQuantityButton.topAnchor.constraint(equalTo: confirmButton.bottomAnchor),
        ])
    }
    
    func show() {
        viewModel.getPointsCount { [weak self] credits in
            self?.points = credits
            
            DispatchQueue.main.async {
                self?.pointsLabel.attributedText =
                    PaymentStrings.pointsFullTitle("\(credits)").text()
                    .changeTextPathColor(PaymentStrings.pointsTitle("\(credits)").text(), color: .orange)
            }
        }
        
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.transparentView.alpha = 0.3
            self?.layoutIfNeeded()
        }
    }
    
    func dismiss(_ completion: (() -> ())? = nil) {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            if completion != nil { self?.transparentView.alpha = 0 }
            self?.layoutIfNeeded()
        } completion: { _ in
            completion?()
        }
    }
    
    @objc private func confirmButtonPressed() {
        dismissCallback?(points)
        dismiss { [weak self] in
            self?.removeFromSuperview()
        }
    }
    
    @objc private func otherQuantityButtonPressed() {
        dismiss()
        
        addSubview(otherQuantityPointsView)
        NSLayoutConstraint.activate([
            otherQuantityPointsView.leadingAnchor.constraint(equalTo: leadingAnchor),
            otherQuantityPointsView.trailingAnchor.constraint(equalTo: trailingAnchor),
            otherQuantityPointsView.topAnchor.constraint(equalTo: topAnchor),
            otherQuantityPointsView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        layoutIfNeeded()
        otherQuantityPointsView.show()
    }
}
