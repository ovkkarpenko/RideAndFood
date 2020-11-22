//
//  CardContainerViewModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

struct CardContainerViewModel {
    let contentView: UIView
    let style: CardViewStyle
    let paddingBottom: CGFloat
    let didSwipeDownCallback: (() -> Void)?
}
