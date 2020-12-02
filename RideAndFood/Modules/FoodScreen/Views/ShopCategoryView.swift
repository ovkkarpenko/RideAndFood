//
//  ShopCategoryView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class ShopCategoryView: UIView {
    
    weak var delegate: FoodViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.rx.tap
            .subscribe(onNext: {
                self.delegate?.showShop(address: nil)
            }).disposed(by: bag)
        
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = ColorHelper.secondaryText.color()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shopNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.rx.tap
            .subscribe(onNext: { _ in
                self.delegate?.showShopDetails()
            }).disposed(by: bag)
        
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = ColorHelper.primary.color()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var bottomLine = CALayer()
    
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 158, height: 120)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        setupCollectionView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.backgroundColor = ColorHelper.disabledButton.color()?.cgColor
        bottomLine.frame = CGRect(x: 0,
                                  y: padding+40,
                                  width: frame.width,
                                  height: 1)
    }
    
    private let padding: CGFloat = 20
    
    private let bag = DisposeBag()
    private let viewModel = ShopCategoryViewModel()
    
    func setupLayout() {
        addSubview(backButton)
        addSubview(shopNameLabel)
        addSubview(infoButton)
        layer.addSublayer(bottomLine)
        addSubview(categoriesCollectionView)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            shopNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            shopNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            infoButton.topAnchor.constraint(equalTo: topAnchor, constant: padding-2),
            infoButton.leadingAnchor.constraint(equalTo: shopNameLabel.trailingAnchor, constant: 5),
            
            categoriesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoriesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            categoriesCollectionView.topAnchor.constraint(equalTo: shopNameLabel.bottomAnchor, constant: padding+20),
            categoriesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupCollectionView() {
        categoriesCollectionView.rx
            .modelSelected(ShopCategory.self)
            .subscribe(onNext: { [weak self] item in
                
                self?.delegate?.showProductCategory(category: item)
            }).disposed(by: bag)
        
        viewModel.categoriesPublishSubject
            .bind(to: categoriesCollectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: CategoryCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
    }
    
    func loadCategorues(shopId: Int) {
        viewModel.fetchItems(shopId: shopId)
    }
}
