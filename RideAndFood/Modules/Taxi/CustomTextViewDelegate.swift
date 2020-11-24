//
//  CustomTextViewDelegate.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 15.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol CustomTextViewDelegate: class {
    func isTextFieldFilled(state: Bool, senderType: TextViewType)
    func isDestinationAddressSelected(state: Bool)
    func mapButtonTapped()
    func locationButtonTapped(senderType: TextViewType)
}
