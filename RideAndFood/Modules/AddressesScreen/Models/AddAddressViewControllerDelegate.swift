//
//  AddAddressViewControllerDelegate.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 02.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol AddAddressViewControllerDelegate: class {
    func didSelectedAddressAsDestination(address: Address?)
}
