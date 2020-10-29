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
    
    private var profile: Profile?
    
    let items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func fetchItems() {
        ServerApi.shared.getProfile { [weak self] profile in
            guard let profile = profile,
                  let self = self else { return }
            
            self.profile = profile
            
            let isNameEmpty = profile.name == nil || profile.name!.isEmpty
            let isEmailEmpty = profile.email == nil || profile.email!.isEmpty
            
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(title: "+\(profile.phone ?? "")", cellTypes: [.none, .icon(UIImage(systemName: "person.fill"))])
                ]),
                
                SectionModel(model: "Name", items: [
                    TableItem(
                        title: isNameEmpty ? "What is your name?" : profile.name!,
                        cellTypes: [.default(isNameEmpty ? .gray : .black)], completion: { vc in
                            
                            if let alert = UIStoryboard(name: "Settings", bundle: nil)
                                .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
                                
                                alert.buttonTitle = "Confirm"
                                alert.textFieldValue = profile.name ?? ""
                                alert.placeholder = "What is your name?"
                                alert.buttonClickedCallback = { text in
                                    
                                    ServerApi.shared.saveProfile(Profile(name: text)) { profile in
                                        if let _ = profile {
                                            self.fetchItems()
                                        } else {
                                            AlertHelper.shared.alert(vc, title: "Error", message: "Please ensure that you enter your name correctly.")
                                        }
                                    }
                                    
                                }
                                
                                alert.modalPresentationStyle = .popover
                                vc.present(alert, animated: true)
                            }
                        })
                ]),
                
                SectionModel(model: "E-main", items: [
                    TableItem(
                        title: isEmailEmpty ? "Enter your e-mail" : profile.email!,
                        cellTypes: [.default(isEmailEmpty ? .gray : .black)], completion: { vc in
                            
                            if let alert = UIStoryboard(name: "Settings", bundle: nil)
                                .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
                                
                                alert.buttonTitle = "Confirm"
                                alert.textFieldValue = profile.email ?? ""
                                alert.placeholder = "Enter your e-mail"
                                alert.buttonClickedCallback = { text in
                                    
                                    ServerApi.shared.saveProfile(Profile(email: text)) { profile in
                                        if let _ = profile {
                                            self.fetchItems()
                                        } else {
                                            AlertHelper.shared.alert(vc, title: "Error", message: "Please ensure that you enter your\ne-mail correctly.")
                                        }
                                    }
                                }
                                
                                alert.modalPresentationStyle = .popover
                                vc.present(alert, animated: true)
                            }
                        })
                ])
            ])
        }
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
