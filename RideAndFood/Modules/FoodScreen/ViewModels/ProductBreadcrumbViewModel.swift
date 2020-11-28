//
//  ProductBreadcrumbViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 24.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources

class ProductBreadcrumbViewModel {
    
    var itemsPublishSubject = PublishSubject<[SectionModel<String, ShopProduct>]>()
    
    func fetchItems(shopId: Int, subCategoryId: Int, prevCategoryId: Int?, _ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getShopProducts(shopId: shopId, subCategoryId: subCategoryId) { [weak self] items, _ in
            
            if var items = items {
                if let prevCategoryId = prevCategoryId {
                    items.insert(ShopProduct(id: prevCategoryId, name: FoodSelectAddressStrings.backButton.text()), at: 0)
                }
                
                self?.itemsPublishSubject.onNext([SectionModel(model: "", items: items.filter { $0.isCategory })])
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, ShopProduct>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, ShopProduct>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProductBreadcrumbCollectionViewCell
                cell.titleLabel.text = item.name
                return cell
            }
        )
    }
}
