//
//  ShopProductsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class ShopProductsView: UIView {
    
    var delegate: FoodViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.rx.tap
            .subscribe(onNext: {
                self.delegate?.showProductCategory(category: nil)
            }).disposed(by: bag)
        
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = ColorHelper.secondaryText.color()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var subCategoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.primaryText.color()
        label.font = .boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 158, height: 235)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShopProductCollectionViewCell.self, forCellWithReuseIdentifier: ShopProductCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var bottomLines: [CALayer] = [CALayer(), CALayer()]
    
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
        
        setupLines()
    }
    
    private let padding: CGFloat = 20
    
    private let bag = DisposeBag()
    private let viewModel = ShopProductViewModel()
    
    func setupLayout() {
        addSubview(backButton)
        addSubview(categoryLabel)
        addSubview(subCategoryLabel)
        addSubview(productsCollectionView)
        
        bottomLines.forEach { layer.addSublayer($0) }
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            subCategoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            subCategoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: padding),
            
            productsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            productsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            productsCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: padding+70),
            productsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupCollectionView() {
        productsCollectionView.rx
            .modelSelected(FoodShop.self)
            .subscribe(onNext: { item in
                
                //                self?.delegate?.showShopCategory(shop: item)
            }).disposed(by: bag)
        
        viewModel.itemsPublishSubject
            .bind(to: productsCollectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: ShopProductCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
    }
    
    func loadProducts(shopId: Int, subCategoryId: Int) {
        viewModel.fetchItems(shopId: shopId, subCategoryId: subCategoryId)
    }
    
    func setupLines() {
        bottomLines.forEach { $0.backgroundColor = ColorHelper.disabledButton.color()?.cgColor }
        
        bottomLines[0].frame = CGRect(x: 0,
                                      y: categoryLabel.frame.maxY+padding,
                                      width: frame.width,
                                      height: 1)
        
        bottomLines[1].frame = CGRect(x: 0,
                                      y: categoryLabel.frame.maxY+padding+50,
                                      width: frame.width,
                                      height: 1)
    }
}
