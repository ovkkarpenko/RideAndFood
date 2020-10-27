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
    
    let items = Observable.just([
        SectionModel(model: "", items: [
            TableItem(title: "Language", segue: "SettingsLanguageSegue", cellTypes: [.subTitle("Russian")]),
            TableItem(title: "Personal data", segue: "PersonalDataSegue", cellTypes: [.default()]),
            TableItem(title: "Push notification instead of ringing", cellTypes: [.switch])
        ]),
        SectionModel(model: " ", items: [
            TableItem(title: "Stock notifications", cellTypes: [.switch]),
            TableItem(title: "Available shares", segue: "AvailableSharesSegue", cellTypes: [.default()])
        ]),
        SectionModel(model: "Automatic updating of geolocation data", items: [
            TableItem(title: "Refresh over cellular network", cellTypes: [.switch])
        ])
    ])
    
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
