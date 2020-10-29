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
    
    var settings: Settings?
    
    func saveItems() {
        if let settings = settings {
            ServerApi.shared.saveSettings(settings)
        }
    }
    
    func fetchItems() {
        ServerApi.shared.getSettings(completion: { [weak self] settings in
            guard let settings = settings,
                  let self = self else { return }
            
            self.settings = settings
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(
                        title: SettingsStrings.language.text(),
                        segue: "SettingsLanguageSegue",
                        cellTypes: [
                            .subTitle(SettingsStrings.language(.language)(settings.language))
                        ]
                    ),
                    TableItem(title: SettingsStrings.personalData.text(), segue: "PersonalDataSegue", cellTypes: [.default()]),
                    TableItem(
                        title: SettingsStrings.pushNotification.text(),
                        cellTypes: [
                            .switch(settings.doNotCall, { isOn in
                                if let _ = self.settings {
                                    self.settings?.doNotCall = isOn
                                    ServerApi.shared.saveSettings(settings)
                                }
                            })
                        ])
                ]),
                
                SectionModel(model: " ", items: [
                    TableItem(
                        title: SettingsStrings.stockNotifications.text(),
                        cellTypes: [
                            .switch(settings.notificationDiscount, { isOn in
                                if let _ = self.settings {
                                    self.settings?.notificationDiscount = isOn
                                    ServerApi.shared.saveSettings(settings)
                                }
                            })
                        ]),
                    TableItem(title: SettingsStrings.availableShares.text(), segue: "AvailableSharesSegue", cellTypes: [.default()])
                ]),
                
                SectionModel(model: SettingsStrings.automaticUpdatingGeo.text(), items: [
                    TableItem(
                        title: SettingsStrings.refreshNetwork.text(),
                        cellTypes: [
                            .switch(settings.updateMobileNetwork, { isOn in
                                if let _ = self.settings {
                                    self.settings?.updateMobileNetwork = isOn
                                    ServerApi.shared.saveSettings(settings)
                                }
                            })
                        ]),
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
