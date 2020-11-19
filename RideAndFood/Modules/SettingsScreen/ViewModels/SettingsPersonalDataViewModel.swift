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
        ServerApi.shared.getProfile { [weak self] profile, _ in
            guard var profile = profile,
                  let self = self else { return }
            
            self.profile = profile
            
            let isNameEmpty = profile.name == nil || profile.name!.isEmpty
            let isEmailEmpty = profile.email == nil || profile.email!.isEmpty
            
            if var phone = profile.phone {
                phone.insert(contentsOf: "-", at: phone.startIndex(offsetBy: +9))
                phone.insert(contentsOf: "-", at: phone.startIndex(offsetBy: +7))
                phone.insert(contentsOf: ") ", at: phone.startIndex(offsetBy: +4))
                phone.insert(contentsOf: " (", at: phone.startIndex(offsetBy: +1))
                profile.phone = phone
            }
            
            self.items.onNext([
                SectionModel(model: "", items: [
                    TableItem(title: "+\(profile.phone ?? "")", cellTypes: [.none, .icon(UIImage(systemName: "person.fill"))])
                ]),
                
                SectionModel(model: SettingsPersonalDataStrings.name.text(), items: [
                    TableItem(
                        title: isNameEmpty ? SettingsPersonalDataStrings.nameCellTitle.text() : profile.name!,
                        cellTypes: [.default(isNameEmpty ? .gray : .black)], completion: { vc in
                            
                            if let alert = UIStoryboard(name: "Settings", bundle: nil)
                                .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
                                
                                alert.buttonTitle = SettingsPersonalDataStrings.confirm.text()
                                alert.textFieldValue = profile.name ?? ""
                                alert.placeholder = SettingsPersonalDataStrings.nameCellTitle.text()
                                alert.buttonClickedCallback = { text in
                                    
                                    ServerApi.shared.saveProfile(Profile(name: text)) { profile, _ in
                                        if let _ = profile {
                                            self.fetchItems()
                                        } else {
                                            AlertHelper.shared.alert(vc, title: StringsHelper.alertErrorTitle.text(), message: StringsHelper.alertErrorDescription.text())
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
                        title: isEmailEmpty ? SettingsPersonalDataStrings.emailCellTitle.text() : profile.email!,
                        cellTypes: [.default(isEmailEmpty ? .gray : .black)], completion: { vc in
                            
                            if let alert = UIStoryboard(name: "Settings", bundle: nil)
                                .instantiateViewController(withIdentifier: "AlertController") as? AlertTextFieldViewController {
                                
                                alert.buttonTitle = SettingsPersonalDataStrings.confirm.text()
                                alert.textFieldValue = profile.email ?? ""
                                alert.placeholder = SettingsPersonalDataStrings.emailCellTitle.text()
                                alert.buttonClickedCallback = { text in
                                    
                                    ServerApi.shared.saveProfile(Profile(email: text)) { profile, _ in
                                        if let _ = profile {
                                            self.fetchItems()
                                        } else {
                                            AlertHelper.shared.alert(vc, title: StringsHelper.alertErrorTitle.text(), message: StringsHelper.alertErrorDescription.text())
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
