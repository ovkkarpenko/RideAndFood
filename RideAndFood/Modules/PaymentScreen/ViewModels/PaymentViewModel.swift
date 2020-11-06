//
//  PaymentViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 05.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import Foundation

class PaymentViewModel {
    
    var items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func fetchItems() {
        items.onNext(getMenu())
        
        ServerApi.shared.getPaymentCards(completion: { [weak self] cards in
            guard let cards = cards,
                  let self = self else { return }
            
            //            self.items.onNext(self.getMenu(settings: settings))
        })
    }
    
    func dataSource(cellIdentifier: String) -> RxTableViewSectionedReloadDataSource<SectionModel<String, TableItem>> {
        
        return RxTableViewSectionedReloadDataSource<SectionModel<String, TableItem>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier)!
                TableHelper.shared.setupCell(cell, item: item)
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
    }
    
    private func getMenu(_ cards: [PaymentCard]? = nil) -> [SectionModel<String, TableItem>] {
        return [
            SectionModel(model: "", items: [
                TableItem(title: PaymentStrings.cash.text(), cellTypes: [.radio(true), .icon(UIImage(named: "cash", in: Bundle.init(path: "Images/Icons"), with: .none))]),
                TableItem(title: PaymentStrings.card.text(), cellTypes: [.icon(UIImage(named: "card", in: Bundle.init(path: "Images/Icons"), with: .none)), .default()]),
                TableItem(title: PaymentStrings.applePay.text(), cellTypes: [.radio(false), .icon(UIImage(named: "applePay", in: Bundle.init(path: "Images/Icons"), with: .none))]),
            ]),
            
            SectionModel(model: " ", items: [TableItem(title: PaymentStrings.points.text(), cellTypes: [.default(), .icon(UIImage(named: "points", in: Bundle.init(path: "Images/Icons"), with: .none))])])
        ]
    }
}
