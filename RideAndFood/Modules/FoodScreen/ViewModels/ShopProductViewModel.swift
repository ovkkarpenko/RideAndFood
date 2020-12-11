//
//  ShopProductViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources

class ShopProductViewModel {
    
    var itemsPublishSubject = PublishSubject<[SectionModel<String, ShopProduct>]>()

    func fetchItems(shopId: Int, subCategoryId: Int, _ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getShopProducts(shopId: shopId, subCategoryId: subCategoryId) { [weak self] items, _ in
            
            if let items = items {
                self?.itemsPublishSubject.onNext([SectionModel(model: "", items: items.filter { !$0.isCategory })])
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }

    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, ShopProduct>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, ShopProduct>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ShopProductCollectionViewCell
                cell.imageView.imageByUrl(from: URL(string: "\(item.icon)")!)
                cell.nameLabel.text = item.name
                if let price = item.price { cell.priceLabel.text = "\(price) руб" }
                if let weight = item.weight { cell.weightLabel.text = "\(weight) г" }
                return cell
            }
        )
    }
}
