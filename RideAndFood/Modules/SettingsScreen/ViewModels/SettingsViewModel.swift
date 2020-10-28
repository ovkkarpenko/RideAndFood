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
    
    private let api = ServerApi.shared
    var settings: Settings?
    
    func fetchItems(userId: Int) {
        api.getSettings(userId: userId, completion: { [weak self] (result, error) in
            guard let result = result,
                  let self = self else { return }
            
            self.settings = result
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(
                        title: SettingsStrings.language.text(),
                        segue: "SettingsLanguageSegue",
                        cellTypes: [
                            .subTitle(SettingsStrings.language(.language)(result.language))
                        ]
                    ),
                    TableItem(title: SettingsStrings.personalData.text(), segue: "PersonalDataSegue", cellTypes: [.default()]),
                    TableItem(
                        title: SettingsStrings.pushNotification.text(),
                        cellTypes: [
                            .switch(result.doNotCall, { isOn in
                                if var settings = self.settings {
                                    settings.doNotCall = isOn
                                    self.api.saveSettings(settings, userId: userId)
                                }
                            })
                        ])
                ]),
                
                SectionModel(model: " ", items: [
                    TableItem(
                        title: SettingsStrings.stockNotifications.text(),
                        cellTypes: [
                            .switch(result.notificationDiscount, { isOn in
                                if var settings = self.settings {
                                    settings.notificationDiscount = isOn
                                    self.api.saveSettings(settings, userId: userId)
                                }
                            })
                        ]),
                    TableItem(title: SettingsStrings.availableShares.text(), segue: "AvailableSharesSegue", cellTypes: [.default()])
                ]),
                
                SectionModel(model: SettingsStrings.automaticUpdatingGeo.text(), items: [
                    TableItem(
                        title: SettingsStrings.refreshNetwork.text(),
                        cellTypes: [
                            .switch(result.updateMobileNetwork, { isOn in
                                if var settings = self.settings {
                                    settings.updateMobileNetwork = isOn
                                    self.api.saveSettings(settings, userId: userId)
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
