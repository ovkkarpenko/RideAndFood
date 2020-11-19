//
//  AddressViewModel.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation
import RxSwift
import RxDataSources

class AddressViewModel {
    
    var addressesPublishSubject = PublishSubject<[SectionModel<String, Address>]>()
    
    func fetchItems(_ completion: @escaping () -> ()) {
        
        ServerApi.shared.getAddresses{ [weak self] addresses, _ in
            
            if let addresses = addresses {
                self?.addressesPublishSubject
                    .onNext([SectionModel(model: "", items: addresses)])
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxTableViewSectionedReloadDataSource<SectionModel<String, Address>> {
        
        return RxTableViewSectionedReloadDataSource<SectionModel<String, Address>>(
            configureCell: { (_, tv, indexPath, item) in
                
                if let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier) as? AddressTableViewCell {
                    cell.nameLabel.text = item.name
                    cell.addressLabel.text = item.address
                    return cell
                } else {
                    let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier)!
                    cell.textLabel?.text = item.name
                    return cell
                }
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
    }
}
