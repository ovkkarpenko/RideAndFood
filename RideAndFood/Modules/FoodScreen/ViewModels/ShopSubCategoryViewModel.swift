//
//  ShopSubCategoryViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 21.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ShopSubCategoryViewModel {
    
    var itemsPublishSubject = PublishSubject<[SectionModel<String, ShopSubCategory>]>()
    
    func fetchItems(shopId: Int, _ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getShopSubCategory(shopId: shopId){ [weak self] items, _ in
            
            if let items = items {
                self?.itemsPublishSubject.onNext([SectionModel(model: "", items: items)])
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxTableViewSectionedReloadDataSource<SectionModel<String, ShopSubCategory>> {
        
        return RxTableViewSectionedReloadDataSource<SectionModel<String, ShopSubCategory>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                cell.textLabel?.text = item.name
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        )
    }
}

