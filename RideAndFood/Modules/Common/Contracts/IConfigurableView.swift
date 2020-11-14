//
//  IConfigurableView.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 13.11.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

protocol IConfigurableView {
    associatedtype ConfigurationModel
    
    func configure(with model: ConfigurationModel)
}
