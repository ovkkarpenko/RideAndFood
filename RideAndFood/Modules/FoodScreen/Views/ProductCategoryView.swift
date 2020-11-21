//
//  ProductCategoryView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class ProductCategoryView: UIView {
    
    var delegate: FoodViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        
        button.rx.tap
            .subscribe(onNext: {
                self.delegate?.showShopCategory(shop: nil)
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
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.primaryText.color()
        label.font = .boldSystemFont(ofSize: 26)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var bottomLine = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        setupTableView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        bottomLine.backgroundColor = ColorHelper.disabledButton.color()?.cgColor
        bottomLine.frame = CGRect(x: 0,
                                  y: padding+90,
                                  width: frame.width,
                                  height: 1)
    }
    
    private let padding: CGFloat = 20
    private let cellIdentifier = "SubCategoryCell"
    
    private let bag = DisposeBag()
    private let viewModel = ShopSubCategoryViewModel()
    
    func setupLayout() {
        addSubview(backButton)
        addSubview(shopNameLabel)
        addSubview(categoryLabel)
        layer.addSublayer(bottomLine)
        addSubview(tableView)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            backButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            shopNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            shopNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: padding),
            
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: padding),
            tableView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupTableView() {
        tableView.rx
            .modelSelected(FoodShop.self)
            .subscribe(onNext: { [weak self] item in
                
                //                self?.delegate?.showProductCategory(category: item)
            }).disposed(by: bag)
        
        viewModel.itemsPublishSubject
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource(cellIdentifier: cellIdentifier)))
            .disposed(by: bag)
    }
    
    func loadSubCategorues(shopId: Int) {
        viewModel.fetchItems(shopId: shopId)
    }
}
