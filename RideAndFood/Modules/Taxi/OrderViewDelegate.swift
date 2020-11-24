//
//  OrderViewDelegate.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 22.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol OrderViewDelegate: class {
    func shouldShowTranspatentView()
    func shouldRemoveTranspatentView()
    func buttonTapped(newSubview: OrderViewDirector?)
    func locationButtonTapped(senderType: TextViewType)
}
