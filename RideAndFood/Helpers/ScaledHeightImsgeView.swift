//
//  ScaledHeightImageView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 28.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class ScaledHeightImageView: UIImageView {

    override var intrinsicContentSize: CGSize {
        if let myImage = self.image {
            let myImageWidth = myImage.size.width
            let myImageHeight = myImage.size.height
            let myViewWidth = self.frame.size.width
            
            let ratio = myViewWidth / myImageWidth
            let scaledHeight = myImageHeight * ratio
            
            return CGSize(width: myViewWidth, height: scaledHeight)
        }
        return CGSize(width: -1.0, height: -1.0)
    }
}
