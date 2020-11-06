//
//  BindCardViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 06.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import Foundation

class BindCardViewModel {
    
    var cardNumber = PublishSubject<String>()
    var cardDate = PublishSubject<String>()
    var cardCVV = PublishSubject<String>()
    
    func isCompleted() -> Observable<Bool> {
        return Observable.combineLatest(
            cardNumber.asObserver(),
            cardDate.asObserver(),
            cardCVV.asObserver()) { number, date, cvv in
            
            return number.count == 19 && date.count == 5 && cvv.count == 3
        }
    }
}
