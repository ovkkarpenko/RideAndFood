//
//  SettingsPersonalDataViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 26.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import Foundation

class SettingsPersonalDataViewModel {
    
    let items = Observable.just([
        SectionModel(model: "", items: [
            TableItem(title: "+7 (944) 534-32-53", cellTypes: [.none, .icon(UIImage(systemName: "person.fill"))])
        ]),
        SectionModel(model: "Name", items: [
            TableItem(title: "What is your name?", cellTypes: [.default(.gray)], completion: { vc in
                AlertTextFieldViewController.show(vc, buttonTitle: "Confirm", placeholder: "What is your name?")
            })
        ]),
        SectionModel(model: "E-main", items: [
            TableItem(title: "Enter your e-mail", cellTypes: [.default(.gray)], completion: { vc in
                AlertTextFieldViewController.show(vc, buttonTitle: "Confirm", placeholder: "Enter your e-mail")
            })
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
