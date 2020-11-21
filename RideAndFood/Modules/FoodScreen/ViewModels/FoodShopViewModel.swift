//
//  FoodShopViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class FoodShopViewModel {
    
    var shopsPublishSubject = PublishSubject<[SectionModel<String, FoodShop>]>()
    
    func fetchItems(_ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getShops{ [weak self] shops, _ in
            
            if let shops = shops {
                self?.shopsPublishSubject.onNext([SectionModel(model: "", items: shops)])
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, FoodShop>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, FoodShop>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShopCollectionViewCell
                cell.imageView.imageByUrl(from: URL(string: "\(baseUrl)\(item.icon)")!)
                cell.nameLabel.text = item.name
                return cell
            }
        )
    }
}
