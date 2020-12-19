//
//  PointsViewDelegate.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 17.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol PointsViewDelegate: class {
    func setPointsToSpend(points: String)
    func spendAllPoints()
}
