//
//  FoodCategoryViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class FoodCategoryViewModel {
    
    var categoriesPublishSubject = PublishSubject<[SectionModel<String, ShopCategories>]>()
    
    func fetchItems(shopId: Int, _ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getShopDetails(shopId: shopId){ [weak self] item, _ in
            
            if let item = item {
                self?.categoriesPublishSubject.onNext([SectionModel(model: "", items: item.categories)])
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, ShopCategories>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, ShopCategories>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CategoryCollectionViewCell
                cell.imageView.imageByUrl(from: URL(string: "\(baseUrl)\(item.icon)")!)
                cell.nameLabel.text = item.name
                return cell
            }
        )
    }
}

