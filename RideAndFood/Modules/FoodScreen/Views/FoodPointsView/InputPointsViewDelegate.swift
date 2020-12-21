//
//  InputPointsViewDelegate.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 16.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol InputPointsViewDelegate: class {
    func confirmButtonPressed(enteredPointsCount: String)
    func cancelSwipeOccurred()
}
