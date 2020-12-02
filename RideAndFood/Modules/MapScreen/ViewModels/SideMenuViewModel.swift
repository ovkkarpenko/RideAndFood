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
    
    let itemsPublishSubject = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func fetchItems() {
        let items = [
            SectionModel(model: "", items: [
                TableItem(title: SideMenuStrings.support.text(), cellTypes: [.default()], completion: { vc in
                    if let controller = UIStoryboard.init(name: "SupportService", bundle: nil)
                        .instantiateViewController(withIdentifier: "SupportID") as? UINavigationController {
                        
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .crossDissolve
                        vc.present(controller, animated: true)
                    }
                }),
                TableItem(title: SideMenuStrings.settings.text(), cellTypes: [.default()], completion: { vc in
                    if let controller = UIStoryboard.init(name: "Settings", bundle: nil)
                        .instantiateViewController(withIdentifier: "SettingsNavigationController") as? UINavigationController {
                        
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .crossDissolve
                        vc.present(controller, animated: true)
                    }
                }),
                TableItem(
                    title: SideMenuStrings.paymentMethod.text(),
                    cellTypes: [.default(), .icon(UIImage(named: "visa", in: Bundle.init(path: "Images/Icons"), with: .none))],
                    completion: { vc in
                        let controller = PaymentViewController()
                        let backbutton = UIButton(type: .custom)
                        backbutton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
                        backbutton.tintColor = .gray
                        
                        _ = backbutton.rx
                            .tap
                            .subscribe(onNext: {
                            controller.navigationController?.dismiss(animated: true)
                        })
                        
                        controller.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backbutton)
                        let navigationController = UINavigationController(rootViewController: controller)
                        navigationController.modalPresentationStyle = .fullScreen
                        navigationController.modalTransitionStyle = .crossDissolve
                        vc.present(navigationController, animated: true)
                    })
            ]),
            
            SectionModel(model: " ", items: [
                TableItem(
                    title: SideMenuStrings.tariffs.text(),
                    cellTypes: [.default()],
                    completion: { vc in
                        if let controller = UIStoryboard.init(name: "Tariff", bundle: nil)
                            .instantiateViewController(withIdentifier: "TariffID") as? UINavigationController {
                            
                            controller.modalPresentationStyle = .fullScreen
                            controller.modalTransitionStyle = .crossDissolve
                            vc.present(controller, animated: true)
                        }
                    }),
                TableItem(
                    title: SideMenuStrings.promoCode.text(),
                    cellTypes: [.default(), .icon(UIImage(named: "promo", in: Bundle.init(path: "Images/Icons"), with: .none))],
                    completion: { vc in
                        let promoCodesVC = PromoCodesViewController()
                        let controller = UINavigationController(rootViewController: promoCodesVC)
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .crossDissolve
                        vc.present(controller, animated: true)
                    }),
                TableItem(title: SideMenuStrings.promotions.text(), cellTypes: [.default()], completion: { vc in
                    if let controller = UIStoryboard.init(name: "Settings", bundle: nil)
                        .instantiateViewController(withIdentifier: "AvailablePromotionsController")  as? UINavigationController {
                        
                        controller.modalPresentationStyle = .fullScreen
                        controller.modalTransitionStyle = .crossDissolve
                        vc.present(controller, animated: true)
                    }
                })
            ])
        ]
        itemsPublishSubject.onNext(items)
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
