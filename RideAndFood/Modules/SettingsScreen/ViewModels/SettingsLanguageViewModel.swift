//
//  SettingsLanguageViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 25.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import Foundation

class SettingsLanguageViewModel {
    
    var settings: Settings?
    var items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    private var language: [TableItem] = []
    
    func selectLanguage(userId: Int, checkedItem: TableItem) {
        if var settings = self.settings {
            settings.language = checkedItem.title == "Русский" ? "rus" : "eng"
            ServerApi.shared.saveSettings(settings)
        }
        
        for i in 0..<language.count {
            language[i].cellTypes = [.radio(language[i].title == checkedItem.title)]
        }
        items.onNext([SectionModel(model: "", items: language)])
    }
    
    func fetchItems() {
        if let settings = self.settings {
            language = [
                TableItem(title: "Русский", cellTypes: [.radio(settings.language == "rus")]),
                TableItem(title: "English", cellTypes: [.radio(settings.language == "eng")])
            ]
        }
        items.onNext([SectionModel(model: "", items: language)])
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
