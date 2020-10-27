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
    
    private var language: [TableItem] = []
    var items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func selectLanguage(checkedItem: TableItem) {
        language = language.map { item in
            return TableItem(title: item.title, cellTypes: [.radio(item.title == checkedItem.title)])
        }
        items.onNext([SectionModel(model: "", items: language)])
    }
    
    func fetchItems() {
        language = [
            TableItem(title: "Русский", cellTypes: [.radio(true)]),
            TableItem(title: "English", cellTypes: [.radio(false)])
        ]
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
