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
    
    func fetchItems(userId: Int) {
        api.getSettings(userId: userId, completion: { (settings, error) in
            guard let settings = settings else { return }
            
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(title: SettingsStrings.language.text(), segue: "SettingsLanguageSegue", cellTypes: [.subTitle(SettingsStrings.language(.language)(settings.language))]),
                    TableItem(title: SettingsStrings.personalData.text(), segue: "PersonalDataSegue", cellTypes: [.default()]),
                    TableItem(title: SettingsStrings.pushNotification.text(), cellTypes: [.switch(settings.doNotCall)])
                ]),
                
                SectionModel(model: " ", items: [
                    TableItem(title: SettingsStrings.stockNotifications.text(), cellTypes: [.switch(settings.notificationDiscount)]),
                    TableItem(title: SettingsStrings.availableShares.text(), segue: "AvailableSharesSegue", cellTypes: [.default()])
                ]),
                
                SectionModel(model: SettingsStrings.automaticUpdatingGeo.text(), items: [
                    TableItem(title: SettingsStrings.refreshNetwork.text(), cellTypes: [.switch(settings.updateMobileNetwork)])
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
