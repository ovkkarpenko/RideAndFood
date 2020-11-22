//
//  ShopDetailsViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class ShopDetailsViewModel {
    
    var itemsPublishSubject = PublishSubject<ShopDetails>()
    
    func fetchItems(shopId: Int, _ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getShopDetails(shopId: shopId){ [weak self] item, _ in
            
            if let item = item {
                self?.itemsPublishSubject.onNext(item)
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
}
