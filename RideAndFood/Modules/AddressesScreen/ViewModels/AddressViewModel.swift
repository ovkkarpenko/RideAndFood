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

enum AddressViewModelType {
    case addAddress
    case selectAddress
}

class AddressViewModel {
    
    var type: AddressViewModelType
    var addressesPublishSubject = PublishSubject<[SectionModel<String, Address>]>()
    
    init(type: AddressViewModelType) {
        self.type = type
    }
    
    func fetchItems(_ completion: (() -> ())? = nil) {
        
        ServerApi.shared.getAddresses{ [weak self] addresses, _ in
            
            if let addresses = addresses {
                self?.addressesPublishSubject.onNext([SectionModel(model: "", items: addresses)])
                
                DispatchQueue.main.async {
                    completion?()
                }
            }
        }
    }
    
    func dataSource(cellIdentifier: String) -> RxTableViewSectionedReloadDataSource<SectionModel<String, Address>> {
        
        return RxTableViewSectionedReloadDataSource<SectionModel<String, Address>>(
            configureCell: { (_, tv, indexPath, item) in
                
                let cell = tv.dequeueReusableCell(withIdentifier: cellIdentifier) as! AddressTableViewCell
                
                if self.type == .addAddress {
                    cell.nameLabel.text = item.name
                    cell.addressLabel.text = item.address
                    cell.iconImageView.image = UIImage(named: "home", in: Bundle.init(path: "Images/Icons"), with: .none)
                } else {
                    cell.nameLabel.text = item.name
                    cell.addressLabel.text = item.address
                    cell.iconImageView.image = UIImage(named: "clock", in: Bundle.init(path: "Images/Icons"), with: .none)
                    cell.accessoryType = .none
                }
                
                return cell
            },
            titleForHeaderInSection: { dataSource, sectionIndex in
                return dataSource[sectionIndex].model
            }
        )
    }
}
