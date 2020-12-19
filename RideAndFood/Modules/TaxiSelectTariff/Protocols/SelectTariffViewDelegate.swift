//
//  SelectTariffViewDelegate.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

protocol SelectTariffViewDelegate: class {
    func promoCodeButtonPressed(_ dismissCallback: ((String?) -> ())?)
    func pointsButtonPressed(_ dismissCallback: ((Int?) -> ())?)
    func backSubButtonPressed()
    func orderButtonPressed(order: TaxiOrder)
    func confirmOrderButtonPressed()
    func cencelOrderButtonPressed()
    func foundTaxi(order: TaxiOrder?)
}
