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
    
    var settings: Settings?
    var items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func saveItems() {
        if let settings = settings {
            ServerApi.shared.saveSettings(settings)
        }
    }
    
    func fetchItems() {
        items.onNext(getMenu())
        
        ServerApi.shared.getSettings(completion: { [weak self] settings, _ in
            guard let settings = settings,
                  let self = self else { return }
            
            self.settings = settings
            self.items.onNext(self.getMenu(settings: settings))
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
    
    private func getMenu(settings: Settings? = nil) -> [SectionModel<String, TableItem>] {
        return [
            SectionModel(model: "", items: [
                TableItem(
                    title: SettingsStrings.language.text(),
                    segue: "SettingsLanguageSegue",
                    cellTypes: [
                        .subTitle(SettingsStrings.language(.language)())
                    ]
                ),
                TableItem(title: SettingsStrings.personalData.text(), segue: "PersonalDataSegue", cellTypes: [.default()]),
                TableItem(
                    title: SettingsStrings.pushNotification.text(),
                    cellTypes: [
                        .switch(settings?.doNotCall ?? false, { [weak self] isOn in
                            if let _ = self?.settings {
                                self?.settings?.doNotCall = isOn
                                if let settings = settings { ServerApi.shared.saveSettings(settings) }
                            }
                        })
                    ])
            ]),
            
            SectionModel(model: " ", items: [
                TableItem(
                    title: SettingsStrings.stockNotifications.text(),
                    cellTypes: [
                        .switch(settings?.notificationDiscount ?? false, { [weak self] isOn in
                            if let _ = self?.settings {
                                self?.settings?.notificationDiscount = isOn
                                if let settings = settings { ServerApi.shared.saveSettings(settings) }
                            }
                        })
                    ]),
                TableItem(title: SettingsStrings.availableShares.text(), segue: "AvailableSharesSegue", cellTypes: [.default()])
            ]),
            
            SectionModel(model: SettingsStrings.automaticUpdatingGeo.text(), items: [
                TableItem(
                    title: SettingsStrings.refreshNetwork.text(),
                    cellTypes: [
                        .switch(settings?.updateMobileNetwork ?? false, { [weak self] isOn in
                            if let _ = self?.settings {
                                self?.settings?.updateMobileNetwork = isOn
                                if let settings = settings { ServerApi.shared.saveSettings(settings) }
                            }
                        })
                    ]),
            ])
        ]
    }
}
