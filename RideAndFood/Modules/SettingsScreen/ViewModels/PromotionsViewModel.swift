//
//  PromotionsViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import Foundation

class PromotionsViewModel {
    
    var items = PublishSubject<[SectionModel<String, Promotion>]>()
    
    func fetchItems(_ promotionType: PromotionType) {
        ServerApi.shared.getPromotions { [weak self] promotions in
            guard let self = self,
                  var promotions = promotions else { return }
            
            promotions = promotions.filter { return $0.type == promotionType }
            self.items.onNext([SectionModel(model: "", items: promotions)])
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxCollectionViewSectionedReloadDataSource<SectionModel<String, Promotion>> {
        
        return RxCollectionViewSectionedReloadDataSource<SectionModel<String, Promotion>>(
            configureCell: { (_, cv, indexPath, item) in
                
                let cell = cv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
                
                if let cell = cell as? PromotionCollectionViewCell {
                    cell.layer.cornerRadius = 20
                    cell.detailsButton.layer.cornerRadius = 8
                    
                    cell.title.text = item.title
                    cell.detailsButton.setTitle(PromotionsStrings.details.text(), for: .normal)
                    if item.media.count >= 2,
                       let url = URL(string: baseUrl + item.media[1].url) {
                        cell.imageView.imageByUrl(from: url)
                    }
                    return cell
                }
                return cell
            }
        )
    }
}
