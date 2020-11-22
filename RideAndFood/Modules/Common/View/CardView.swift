//
//  CardView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 09.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class CardView: UIView {
     
    // MARK: - UI
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var contentView: UIView?
    private lazy var pickerLineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = pickerLineHeight / 2
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let pickerLineWidth: CGFloat = 40
    private let pickerLineHeight: CGFloat = 5
    private let pickerLineMargin: CGFloat = 10
    private let padding: CGFloat = 25
    private var paddingBottom: CGFloat = 25
    private let cornerRadius: CGFloat = 15
    private let shadowOpacity: Float = 0.2
    private let shadowRadius: CGFloat = 10
    
    // MARK: - Private properties
    
    private var didSwipeDownCallback: (() -> Void)?
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func setupLayout() {
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeDown))
        swipeRecognizer.direction = .down
        addGestureRecognizer(swipeRecognizer)
        backgroundView.layer.cornerRadius = cornerRadius
        backgroundView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        backgroundView.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        backgroundView.layer.shadowOpacity = shadowOpacity
        backgroundView.layer.shadowRadius = shadowRadius
        backgroundView.backgroundColor = ColorHelper.background.color()
        
        addSubview(backgroundView)
        addSubview(pickerLineView)
        
        NSLayoutConstraint.activate([
            pickerLineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerLineView.topAnchor.constraint(equalTo: topAnchor),
            pickerLineView.bottomAnchor.constraint(equalTo: backgroundView.topAnchor, constant: -pickerLineMargin),
            pickerLineView.widthAnchor.constraint(equalToConstant: pickerLineWidth),
            pickerLineView.heightAnchor.constraint(equalToConstant: pickerLineHeight),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func setupContentView() {
        guard let contentView = contentView else { return }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: padding),
            contentView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -padding),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -paddingBottom)
        ])
    }
    
    private func updateStyle(_ style: CardViewStyle) {
        switch style {
        case .light:
            pickerLineView.backgroundColor = ColorHelper.transparentWhite.color()
        case .dark:
            pickerLineView.backgroundColor = ColorHelper.transparentGray.color()
        }
    }
    
    @objc private func didSwipeDown() {
        didSwipeDownCallback?()
    }
}

// MARK: - IConfigurableView

extension CardView: IConfigurableView {
    func configure(with model: CardContainerViewModel) {
        didSwipeDownCallback = model.didSwipeDownCallback
        paddingBottom = model.paddingBottom
        updateStyle(model.style)
        contentView?.removeFromSuperview()
        contentView = model.contentView
        setupContentView()
    }
}

// MARK: - Style

enum CardViewStyle {
    case light
    case dark
}
