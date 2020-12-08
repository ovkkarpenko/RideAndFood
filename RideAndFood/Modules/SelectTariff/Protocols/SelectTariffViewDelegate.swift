//
//  SelectTariffViewDelegate.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

protocol SelectTariffViewDelegate: class {
    func promoCodeButtonPressed(_ ifPromoCodeIsValidCallback: (() -> ())?)
    func pointsButtonPressed(_ ifEnteredPointsCallback: (() -> ())?)
    func backSubButtonPressed()
}
