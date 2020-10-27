//
//  SettingsViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 24.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources
import Foundation

class SettingsViewModel {
    
    var items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    private let api = ServerApi()
    
    func fetchItems() {
        api.getSettings(userId: 33, completion: { (settings, error) in
            guard let settings = settings else { return }
            
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(title: "Language", segue: "SettingsLanguageSegue", cellTypes: [.subTitle("English")]),
                    TableItem(title: "Personal data", segue: "PersonalDataSegue", cellTypes: [.default()]),
                    TableItem(title: "Push notification instead of ringing", cellTypes: [.switch(settings.doNotCall)])
                ]),
                SectionModel(model: " ", items: [
                    TableItem(title: "Stock notifications", cellTypes: [.switch(settings.notificationDiscount)]),
                    TableItem(title: "Available shares", segue: "AvailableSharesSegue", cellTypes: [.default()])
                ]),
                SectionModel(model: "Automatic updating of geolocation data", items: [
                    TableItem(title: "Refresh over cellular network", cellTypes: [.switch(settings.updateMobileNetwork)])
                ])
            ])
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
}
