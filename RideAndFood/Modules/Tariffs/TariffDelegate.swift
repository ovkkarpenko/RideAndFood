//
//  TariffDelegate.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 01.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol TariffDelegate: class {
    func tariffOrderButtonTapped(tariff: TariffModel)
}
