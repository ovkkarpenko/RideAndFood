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
    
    weak var delegate: SelectTariffViewDelegate?
    
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
    
    private lazy var backButton: UIButton = {
        let button = RoundButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        button.tintColor = Colors.getColor(.textBlack)()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var tripDurationView: TripDurationView = {
        let view = TripDurationView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width/3-padding, height: 90)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(TaxiTariffCollectionViewCell.self, forCellWithReuseIdentifier: TaxiTariffCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var promoCodeView: PromoCodeButtonView = {
        let view = PromoCodeButtonView()
        view.buttonPressedCallback = { [weak self] in
            if self?.activatedTariffCell == nil { self?.activatedTariffCell = self?.collectionView.cellForItem(at: .init(row: 0, section: 0)) as? TaxiTariffCollectionViewCell }
            
            self?.delegate?.promoCodeButtonPressed { promoCode in
                self?.activatedTariffCell?.tripPriceLabel.isHidden = false
                self?.promoCode = promoCode ?? ""
                view.disable()
            }
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var pointsView: PointsButtonView = {
        let view = PointsButtonView()
        view.buttonPressedCallback = { [weak self] in
            guard let self = self else { return }
            
            if self.activatedTariffCell == nil { self.activatedTariffCell = self.collectionView.cellForItem(at: .init(row: 0, section: 0)) as? TaxiTariffCollectionViewCell }
            
            self.delegate?.pointsButtonPressed { points in
                if points != 0 {
                    self.activatedTariffCell?.tripPriceLabel.isHidden = false
                    self.points = points ?? 0
                    view.disable(points)
                }
            }
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var orderButton: PrimaryButton = {
        let button = PrimaryButton(title: SelectTariffStrings.order.text())
        button.addTarget(self, action: #selector(orderButtonPressed), for: .touchUpInside)
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
    
    private var points = 0
    private var promoCode = ""
    private var activatedTariffCell: TaxiTariffCollectionViewCell?
    
    private let padding: CGFloat = 20
    private let offset: CGFloat = UIScreen.main.bounds.height-430
    private let screenHeight = UIScreen.main.bounds.height
    
    private let bag = DisposeBag()
    private let viewModel = SelectTariffViewModel()
    
    private lazy var contentViewTopAnchorConstraint = contentView.topAnchor.constraint(equalTo: topAnchor, constant: screenHeight+offset)
    private lazy var contentViewBottomAnchorConstraint = contentView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -screenHeight-offset)
    private lazy var tripDurationViewTopAnchorConstraint = tripDurationView.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: -50)
    
    private func setupUI() {
        addSubview(contentView)
        addSubview(backButton)
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
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding+5),
            backButton.safeAreaLayoutGuide.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding+5),
            
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
            promoCodeView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2-padding-10),
            promoCodeView.heightAnchor.constraint(equalToConstant: 50),
            
            pointsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            pointsView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: padding),
            pointsView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2-padding-10),
            pointsView.heightAnchor.constraint(equalToConstant: 50),
            
            orderButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            orderButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            orderButton.topAnchor.constraint(equalTo: promoCodeView.bottomAnchor, constant: padding)
        ])
    }
    
    func setupCollectionView() {
        collectionView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                for i in 0..<self.collectionView.numberOfItems(inSection: indexPath.section) {
                    
                    if let cell = self.collectionView.cellForItem(at: .init(row: i, section: indexPath.section)) as? TaxiTariffCollectionViewCell {
                        if i == indexPath.row {
                            if let activatedTariffCell = self.activatedTariffCell, !activatedTariffCell.tripPriceLabel.isHidden {
                                cell.tripPriceLabel.isHidden = false
                                activatedTariffCell.tripPriceLabel.isHidden = true
                            }
                            
                            cell.setStatus(true)
                            self.activatedTariffCell = cell
                        } else {
                            cell.setStatus(false)
                        }
                    }
                }
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
        } completion: { [weak self] _ in
            self?.removeFromSuperview()
        }
    }
    
    @objc private func backButtonPressed() {
        dismiss()
        delegate?.backSubButtonPressed()
    }
    
    @objc private func orderButtonPressed() {
        if activatedTariffCell == nil { activatedTariffCell = collectionView.cellForItem(at: .init(row: 0, section: 0)) as? TaxiTariffCollectionViewCell }
        
        if let tariffId = activatedTariffCell?.tariff?.id,
           let from = firstTextField.textField.text,
           let to = secondTextField.textField.text {
            
            let order = TaxiOrder(
                tariff: tariffId,
                from: from, to: to,
                paymentCard: 0, paymentMethod: PaymentType.cash.rawValue,
                promoCodes: [promoCode],
                credit: points)
            
            ServerApi.shared.orderTaxi(order, completion: { [weak self] result, error in
                
                DispatchQueue.main.async {
                    self?.dismiss()
                    self?.delegate?.orderButtonPressed()
                }
            })
        }
    }
}
