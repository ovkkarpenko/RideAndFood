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
    
    private var contentView: UIView?
    private lazy var pickerLineView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = pickerLineHeight / 2
        view.backgroundColor = ColorHelper.transparentGray.color()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let pickerLineWidth: CGFloat = 40
    private let pickerLineHeight: CGFloat = 5
    private let pickerLineMargin: CGFloat = 10
    private let padding: CGFloat = 25
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
        layer.cornerRadius = cornerRadius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
        backgroundColor = ColorHelper.background.color()
        
        addSubview(pickerLineView)
        
        NSLayoutConstraint.activate([
            pickerLineView.centerXAnchor.constraint(equalTo: centerXAnchor),
            pickerLineView.bottomAnchor.constraint(equalTo: topAnchor, constant: -pickerLineMargin),
            pickerLineView.widthAnchor.constraint(equalToConstant: pickerLineWidth),
            pickerLineView.heightAnchor.constraint(equalToConstant: pickerLineHeight),
        ])
    }
    
    private func setupContentView() {
        guard let contentView = contentView else { return }
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            contentView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            contentView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding)
        ])
    }
    
    @objc private func didSwipeDown() {
        didSwipeDownCallback?()
    }
}

// MARK: - IConfigurableView

extension CardView: IConfigurableView {
    func configure(with model: CardContainerViewModel) {
        didSwipeDownCallback = model.didSwipeDownCallback
        contentView?.removeFromSuperview()
        contentView = model.contentView
        setupContentView()
    }
}
