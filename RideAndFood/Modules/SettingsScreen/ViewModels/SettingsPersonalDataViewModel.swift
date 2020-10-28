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
    private let api = ServerApi.shared
    
    let items = PublishSubject<[SectionModel<String, TableItem>]>()
    
    func fetchItems(userId: Int) {
        api.getProfile(userId) { [weak self] result, error in
            guard let result = result,
                  let self = self else { return }
            
            let isNameEmpty = result.name == nil || result.name!.isEmpty
            let isEmailEmpty = result.email == nil || result.email!.isEmpty
            
            self.profile = result
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(title: "+\(result.phone)", cellTypes: [.none, .icon(UIImage(systemName: "person.fill"))])
                ]),
                
                SectionModel(model: "Name", items: [
                    TableItem(
                        title: isNameEmpty ? "What is your name?" : result.name!,
                        cellTypes: [.default(isNameEmpty ? .gray : .black)], completion: { vc in
                            
                            if let alert = UIStoryboard(name: "Settings", bundle: nil)
                                .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
                                
                                alert.buttonTitle = "Confirm"
                                alert.textFieldValue = result.name ?? ""
                                alert.placeholder = "What is your name?"
                                alert.buttonClickedCallback = { text in
                                    if var profile = self.profile {
                                        profile.name = text
                                        self.api.saveProfile(profile, userId: userId) { isSuccess, error in
                                            if isSuccess {
                                                self.fetchItems(userId: userId)
                                            } else {
                                                AlertHelper.shared.alert(vc, title: "Error", message: "Please ensure that you enter your name correctly.")
                                            }
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
                        title: isEmailEmpty ? "Enter your e-mail" : result.email!,
                        cellTypes: [.default(isEmailEmpty ? .gray : .black)], completion: { vc in
                            
                            if let alert = UIStoryboard(name: "Settings", bundle: nil)
                                .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
                                
                                alert.buttonTitle = "Confirm"
                                alert.textFieldValue = result.email ?? ""
                                alert.placeholder = "Enter your e-mail"
                                alert.buttonClickedCallback = { text in
                                    if var profile = self.profile {
                                        
                                        profile.email = text
                                        self.api.saveProfile(profile, userId: userId) { isSuccess, error in
                                            if isSuccess {
                                                self.fetchItems(userId: userId)
                                            } else {
                                                AlertHelper.shared.alert(vc, title: "Error", message: "Please ensure that you enter your\ne-mail correctly.")
                                            }
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
