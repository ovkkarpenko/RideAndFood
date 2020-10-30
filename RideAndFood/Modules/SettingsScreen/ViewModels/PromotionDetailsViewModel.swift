//
//  PromotionDetailsViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 29.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import Foundation

class PromotionDetailsViewModel {
    
    var item = PublishSubject<PromotionDetails>()
    
    func fetchItem(promotionId: Int) {
        ServerApi.shared.getPromotionDetails(id: promotionId) { [weak self] promotion in
            guard let promotion = promotion,
                  let self = self else { return }
            
            self.item.onNext(promotion)
        }
    }
}
