//
//  FoodShopView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift

class FoodShopView: UIView {
    
    var showCategoryCallback: ((_ shop: Shop) -> ())?
    
    private lazy var addressIcon: UIImageView = {
        let image = UIImage(named: "LocationIconActive", in: Bundle.init(path: "Images/MapScreen"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var addressTextField: UITextField = {
        let textField = MaskTextField()
        textField.keyboardType = .default
        textField.isEnabled = false
        textField.textColor = .gray
        textField.font = .systemFont(ofSize: 12)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var addressNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var shopsCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: 158, height: 80)
        
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ShopCollectionViewCell.self, forCellWithReuseIdentifier: ShopCollectionViewCell.cellIdentifier)
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
    
    private let padding: CGFloat = 20
    
    private let bag = DisposeBag()
    private let viewModel = FoodShopViewModel()
    
    func setupLayout() {
        addSubview(addressIcon)
        addSubview(addressNameLabel)
        addSubview(addressTextField)
        addSubview(shopsCollectionView)
        
        NSLayoutConstraint.activate([
            addressIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addressIcon.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            addressNameLabel.leadingAnchor.constraint(equalTo: addressIcon.leadingAnchor, constant: padding),
            addressNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding-8),
            
            addressTextField.leadingAnchor.constraint(equalTo: addressIcon.leadingAnchor, constant: padding),
            addressTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addressTextField.topAnchor.constraint(equalTo: addressNameLabel.bottomAnchor),
            
            shopsCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            shopsCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            shopsCollectionView.topAnchor.constraint(equalTo: addressTextField.bottomAnchor, constant: padding),
            shopsCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
        ])
        
        
        
    }
    
    func setupCollectionView() {
        shopsCollectionView.rx
            .modelSelected(Shop.self)
            .subscribe(onNext: { [weak self] item in
                
                self?.showCategoryCallback?(item)
            }).disposed(by: bag)
        
        viewModel.shopsPublishSubject
            .bind(to: shopsCollectionView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: ShopCollectionViewCell.cellIdentifier)))
            .disposed(by: bag)
        
        viewModel.fetchItems()
    }
}
