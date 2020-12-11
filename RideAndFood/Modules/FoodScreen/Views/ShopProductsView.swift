//
//  ShopProductsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import NVActivityIndicatorView

class ShopProductsView: BaseFoodView {
    
    var shopId: Int?
    var categoryIds: [Int] = []
    
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
    
    lazy var breadcrumbsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 152, height: 35)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.clipsToBounds = false
        collectionView.register(ProductBreadcrumbCollectionViewCell.self, forCellWithReuseIdentifier: ProductBreadcrumbCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var productsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 158, height: 235)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShopProductCollectionViewCell.self, forCellWithReuseIdentifier: ShopProductCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    private lazy var loaderView: NVActivityIndicatorView = {
        let view = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40), type: .ballPulse, color: ColorHelper.controlBackground.color())
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
    private let productsViewModel = ShopProductViewModel()
    private let productBreadcrumbViewModel = ProductBreadcrumbViewModel()
    
    func setupLayout() {
        addSubview(backButton)
        addSubview(categoryLabel)
        addSubview(subCategoryLabel)
        addSubview(breadcrumbsCollectionView)
        addSubview(productsCollectionView)
        addSubview(loaderView)
        
        bottomLines.forEach { layer.addSublayer($0) }
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            subCategoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            subCategoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: padding),
            
            breadcrumbsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            breadcrumbsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            breadcrumbsCollectionView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: padding+5),
            breadcrumbsCollectionView.heightAnchor.constraint(equalToConstant: 40),
            
            productsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            productsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            productsCollectionView.topAnchor.constraint(equalTo: breadcrumbsCollectionView.bottomAnchor, constant: padding),
            productsCollectionView.bottomAnchor.constraint(equalTo: makeOrderButton.topAnchor, constant: -padding),
            
            loaderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            loaderView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupCollectionView() {
        productsCollectionView.rx
            .modelSelected(ShopProduct.self)
            .subscribe(onNext: { [weak self] item in
                self?.delegate?.showProductDetails(item)
            }).disposed(by: bag)
        
        breadcrumbsCollectionView.rx
            .modelSelected(ShopProduct.self)
            .subscribe(onNext: { [weak self] item in
                
                if let shopId = self?.shopId {
                    guard let self = self else { return }
                    
                    var categoryId: Int?
                    
                    if item.isBackButton && self.categoryIds.count > 1 {
                        _ = self.categoryIds.popLast()
                        categoryId = self.categoryIds.count == 1 ? nil : self.categoryIds.last
                    } else if !item.isBackButton {
                        categoryId = self.categoryIds.last
                        self.categoryIds.append(item.id)
                    }
                    
                    self.productBreadcrumbViewModel.fetchItems(
                        shopId: shopId,
                        subCategoryId: self.categoryIds.count == 1 ? self.categoryIds[0] : item.id,
                        prevCategoryId: categoryId)
                    
                    self.toggleLoader(hide: false)
                    self.productsViewModel.fetchItems(
                        shopId: shopId,
                        subCategoryId: self.categoryIds.count == 1
                            ? self.categoryIds[0]
                            : item.id) {
                        
                        self.toggleLoader(hide: true)
                    }
                }
            }).disposed(by: bag)
        
        productsViewModel.itemsPublishSubject
            .bind(to: productsCollectionView.rx.items(dataSource: productsViewModel.dataSource(cellIdentifier: ShopProductCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
        
        productBreadcrumbViewModel.itemsPublishSubject
            .bind(to: breadcrumbsCollectionView.rx.items(dataSource: productBreadcrumbViewModel.dataSource(cellIdentifier: ProductBreadcrumbCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
    }
    
    func toggleLoader(hide: Bool) {
        if hide {
            loaderView.stopAnimating()
            productsCollectionView.isHidden = false
        } else {
            loaderView.startAnimating()
            productsCollectionView.isHidden = true
        }
    }
    
    func loadProducts(shopId: Int, subCategoryId: Int) {
        productsViewModel.fetchItems(shopId: shopId, subCategoryId: subCategoryId)
        productBreadcrumbViewModel.fetchItems(shopId: shopId, subCategoryId: subCategoryId, prevCategoryId: nil)
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
