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
    
    func userInputs() -> Observable<PaymentCard> {
        return Observable.combineLatest(
            cardNumber.asObserver(),
            cardDate.asObserver(),
            cardCVV.asObserver()) { (number, date, cvv) -> (PaymentCard) in
            
            return PaymentCard(number: number.replacingOccurrences(of: " ", with: ""), expiryDate: date, cvc: cvv)
        }
    }
    
    func addCard(_ card: PaymentCard, completion: @escaping (PaymentCardDetails?) -> ()) {
        ServerApi.shared.savePaymentCard(card, completion: { cardDetails, error in
            
            if let error = error as? RequestError {
                switch error {
                case .forbidden:
                    break
//                    ServerApi.shared.getPaymentCardDetails(id: cardDetails.id, completion: { cardDetails, _ in
//
//                        if let cardDetails = cardDetails,
//                           cardDetails.status == "new" {
//                            return completion(true, cardDetails.id)
//                        }
//                    })
                default:
                    break
                }
            } else if let cardDetails = cardDetails {
                return completion(cardDetails)
            }
            
            completion(nil)
        })
    }
}
