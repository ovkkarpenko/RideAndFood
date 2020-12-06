//
//  SelectTariffView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 03.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class SelectTariffView: UIView {
    
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
    
    private lazy var tripDurationView: UIView = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.text = "≈15 мин"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let view = UIView()
        view.frame.size = .init(width: 125, height: 40)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let colorLeft =  UIColor(red: 0.984, green: 0.557, blue: 0.314, alpha: 1).cgColor
        let colorRight = UIColor(red: 0.239, green: 0.231, blue: 1, alpha: 1).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorLeft, colorRight]
        gradientLayer.locations = [0.24, 0.71]
        gradientLayer.transform = CATransform3DMakeRotation(.pi/2, 0, 0, 1)
        gradientLayer.frame = view.bounds
        gradientLayer.cornerRadius = 15
        
        view.layer.insertSublayer(gradientLayer, at:0)
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
        ])
        
        return view
    }()
    
    private lazy var strokeImageView: UIImageView = {
        let image = UIImage(named: "Stroke")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var firstTextField: CustomTextView = {
        let textField = CustomTextView(textViewType: .currentAddress)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var secondTextField: CustomTextView = {
        let textField = CustomTextView(textViewType: .destinationAddress)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 102, height: 90)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TaxiTariffCollectionViewCell.self, forCellWithReuseIdentifier: TaxiTariffCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var promoCodeView: UIView = {
        let button = UIButton()
        button.addTarget(self, action: #selector(promoCodeButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "promo")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = SelectTariffStrings.promoCodeTitle.text()
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }()
    
    private lazy var pointsView: UIView = {
        let button = UIButton()
        button.addTarget(self, action: #selector(pointsButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "points")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.text = SelectTariffStrings.pointsTitle.text()
        
        let view = UIView()
        view.backgroundColor = .white
        view.layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 3
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 1),
            imageView.widthAnchor.constraint(equalToConstant: 20),
            
            label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            button.topAnchor.constraint(equalTo: view.topAnchor),
            button.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }()
    
    private lazy var orderButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.order.text())
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        setupCollectionView()
    }
    
    private let offset: CGFloat = UIScreen.main.bounds.height-430
    private let padding: CGFloat = 20
    private let screenHeight = UIScreen.main.bounds.height
    private let bag = DisposeBag()
    private let viewModel = SelectTariffViewModel()
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    private lazy var tripDurationViewTopAnchorConstraint = tripDurationView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -50)
    
    private func setupUI() {
        addSubview(contentView)
        addSubview(tripDurationView)
        contentView.addSubview(firstTextField)
        contentView.addSubview(secondTextField)
        contentView.addSubview(strokeImageView)
        contentView.addSubview(collectionView)
        contentView.addSubview(promoCodeView)
        contentView.addSubview(pointsView)
        contentView.addSubview(orderButton)
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentViewTopAnchorConstraint,
            contentViewBottomAnchorConstraint,
            
            tripDurationViewTopAnchorConstraint,
            tripDurationView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -20),
            
            strokeImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            strokeImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding+20),
            strokeImageView.widthAnchor.constraint(equalToConstant: 12),
            
            firstTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            firstTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            firstTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            
            secondTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            secondTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            secondTextField.topAnchor.constraint(equalTo: firstTextField.bottomAnchor, constant: padding),
            
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            collectionView.topAnchor.constraint(equalTo: secondTextField.bottomAnchor, constant: padding),
            collectionView.heightAnchor.constraint(equalToConstant: 95),
            
            promoCodeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            promoCodeView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            promoCodeView.widthAnchor.constraint(equalToConstant: 158),
            promoCodeView.heightAnchor.constraint(equalToConstant: 50),
            
            pointsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            pointsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            pointsView.widthAnchor.constraint(equalToConstant: 158),
            pointsView.heightAnchor.constraint(equalToConstant: 50),
            
            orderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            orderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            orderButton.topAnchor.constraint(equalTo: promoCodeView.bottomAnchor, constant: padding)
        ])
    }
    
    func setupCollectionView() {
        collectionView.rx
            .modelSelected(TariffModel.self)
            .subscribe(onNext: { [weak self] item in
                
            }).disposed(by: bag)
        
        viewModel.tariffsPublishSubject
            .bind(to: collectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: TaxiTariffCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
        
        viewModel.fetchData()
    }
    
    func show() {
        contentViewTopAnchorConstraint.constant = offset
        contentViewBottomAnchorConstraint.constant = 0
        tripDurationViewTopAnchorConstraint.constant = padding+5
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseOut]) { [weak self] in
            self?.layoutIfNeeded()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.001) { [weak self] in
            guard let self = self else { return }
            self.firstTextField.textField.becomeFirstResponder()
            self.secondTextField.textField.becomeFirstResponder()
        }
    }
    
    func dismiss() {
        contentViewTopAnchorConstraint.constant = screenHeight+offset
        contentViewBottomAnchorConstraint.constant = -screenHeight-offset
        tripDurationViewTopAnchorConstraint.constant = -50
        
        UIView.animate(withDuration: generalAnimationDuration, delay: 0, options: [.curveEaseIn]) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
    
    @objc private func promoCodeButtonPressed() {
        dismiss()
    }
    
    @objc private func pointsButtonPressed() {
        dismiss()
    }
}
