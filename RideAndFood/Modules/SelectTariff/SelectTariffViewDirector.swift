//
//  SelectTariffViewDirector.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 03.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit

class SelectTariffViewDirector: SelectTariffView {
    
    convenience init(type: SelectTariffViewType) {
        self.init()
        self.viewType = type
        
        switch type {
        case .tariffInput:
            setupTariffView()
        }
    }
    
    private func setupTariffView() {
        
    }
}
