//
//  SideMenuViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 31.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import RxSwift
import RxDataSources
import Foundation

class SideMenuViewModel {
    
    let items = Observable.just([
        SectionModel(model: "", items: [
            TableItem(title: SideMenuStrings.support.text(), cellTypes: [.default()], completion: { vc in
                if let controller = UIStoryboard.init(name: "SupportService", bundle: nil)
                    .instantiateViewController(withIdentifier: "SupportID") as? UINavigationController {
                    
                    controller.modalPresentationStyle = .fullScreen
                    vc.present(controller, animated: true)
                }
            }),
            TableItem(title: SideMenuStrings.settings.text(), cellTypes: [.default()], completion: { vc in
                if let controller = UIStoryboard.init(name: "Settings", bundle: nil)
                    .instantiateViewController(withIdentifier: "SettingsNavigationController") as? UINavigationController {
                    
                    controller.modalPresentationStyle = .fullScreen
                    vc.present(controller, animated: true)
                }
            }),
            TableItem(title: SideMenuStrings.paymentMethod.text(), cellTypes: [.default()], completion: { vc in
                
            })
        ]),
        
        SectionModel(model: " ", items: [
            TableItem(title: SideMenuStrings.tariffs.text(), cellTypes: [.default()], completion: { vc in
                
            }),
            TableItem(title: SideMenuStrings.promoCode.text(), cellTypes: [.default()], completion: { vc in
                
            }),
            TableItem(title: SideMenuStrings.promotions.text(), cellTypes: [.default()], completion: { vc in
                
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
