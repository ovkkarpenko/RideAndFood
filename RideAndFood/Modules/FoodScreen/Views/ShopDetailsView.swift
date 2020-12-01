//
//  ShopDetailsView.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift

class ShopDetailsView: UIView {
    
    weak var delegate: FoodViewDelegate?
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        
        button.rx.tap
            .subscribe(onNext: {
                self.delegate?.showShopCategory(shop: nil)
            }).disposed(by: bag)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var shopNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.primary.color()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clockIcon: UIImageView = {
        let image = UIImage(named: "clock", in: Bundle.init(path: "Images/Icons"), with: .none)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var scheduleLabel: UILabel = {
        let label = UILabel()
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 4
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 6
        label.textColor = ColorHelper.secondaryText.color()
        label.font = .systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bottomLines: [CALayer] = [CALayer(), CALayer(), CALayer()]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupLayout()
        setupView()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLines()
    }
    
    private let padding: CGFloat = 20
    
    private let bag = DisposeBag()
    private let viewModel = ShopDetailsViewModel()
    
    func setupLayout() {
        addSubview(closeButton)
        addSubview(shopNameLabel)
        addSubview(addressLabel)
        addSubview(clockIcon)
        addSubview(scheduleLabel)
        addSubview(categoriesLabel)
        addSubview(descriptionLabel)
        
        bottomLines.forEach { layer.addSublayer($0) }
        
        NSLayoutConstraint.activate([
            closeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            
            shopNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            shopNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            addressLabel.topAnchor.constraint(equalTo: shopNameLabel.bottomAnchor, constant: -padding+65),
            
            clockIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            clockIcon.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            clockIcon.widthAnchor.constraint(equalToConstant: 12),
            clockIcon.heightAnchor.constraint(equalToConstant: 12),
            
            scheduleLabel.leadingAnchor.constraint(equalTo: clockIcon.trailingAnchor, constant: 8),
            scheduleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            scheduleLabel.topAnchor.constraint(equalTo: addressLabel.bottomAnchor, constant: 5),
            
            categoriesLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoriesLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            categoriesLabel.topAnchor.constraint(equalTo: scheduleLabel.bottomAnchor, constant: padding+15),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            descriptionLabel.topAnchor.constraint(equalTo: categoriesLabel.bottomAnchor, constant: padding+10),
        ])
        
        layer.shadowColor = ColorHelper.shadow.color()?.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.cornerRadius = 15
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func setupView() {
        viewModel.itemsPublishSubject
            .subscribe(onNext: { item in
                
                DispatchQueue.main.async {
                    self.addressLabel.text = item.address
                    self.scheduleLabel.text = item.schedule
                    self.descriptionLabel.text = item.description
                    self.categoriesLabel.text = item.categories.reduce("") { string, item in
                        return string.isEmpty ? item.name : "\(string) • \(item.name)"
                    }
                }
            }).disposed(by: bag)
    }
    
    func setupLines() {
        bottomLines.forEach { $0.backgroundColor = ColorHelper.disabledButton.color()?.cgColor }
        
        bottomLines[0].frame = CGRect(x: 0,
                                      y: shopNameLabel.frame.maxY+padding+5,
                                      width: frame.width,
                                      height: 1)
        
        bottomLines[1].frame = CGRect(x: padding,
                                      y: scheduleLabel.frame.maxY+padding,
                                      width: frame.width-padding*2,
                                      height: 1)
        
        bottomLines[2].frame = CGRect(x: padding,
                                      y: categoriesLabel.frame.maxY+padding-5,
                                      width: frame.width-padding*2,
                                      height: 1)
    }
    
    func loadDetails(shopId: Int) {
        viewModel.fetchItems(shopId: shopId)
    }
}
