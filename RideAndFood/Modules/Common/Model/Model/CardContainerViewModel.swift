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
    let paddingTop: CGFloat
    let paddingBottom: CGFloat
    let paddingX: CGFloat
    let didSwipeDownCallback: (() -> Void)?
    
    init(contentView: UIView,
         style: CardViewStyle = .dark,
         paddingTop: CGFloat = 25,
         paddingBottom: CGFloat = 25,
         paddingX: CGFloat = 25,
         didSwipeDownCallback: (() -> Void)?) {
        self.contentView = contentView
        self.style = style
        self.paddingTop = paddingTop
        self.paddingBottom = paddingBottom
        self.paddingX = paddingX
        self.didSwipeDownCallback = didSwipeDownCallback
    }
}
