//
//  CollectionHelper.swift
//  RideAndFood
//
//  Created by Oleksandr Karpenko on 27.10.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import UIKit
import Foundation

enum ViewCellType {
    case none
    case promo(UIColor)
}

struct CollectionItem {
    var title: String
    var segue: String?
    var cellTypes: [ViewCellType] = []
    var completion: ((UIViewController) -> Void)?
}

class CollectionHelper {
    
    static let shared = CollectionHelper()
    
    private init() { }
    
    func setupCell(_ cell: UICollectionViewCell, item: CollectionItem) {
        
        defaultViewCellConfig(cell)
        
        for cellType in item.cellTypes {
            switch cellType {
            case .none:
                noneCell(cell, title: item.title)
            case .promo(let background):
                promoCell(cell, title: item.title, background: background)
            }
        }
    }
    
    private func noneCell(_ cell: UICollectionViewCell, title: String) {
        
    }
    
    private func promoCell(_ cell: UICollectionViewCell, title: String, background: UIColor) {
        
    }
    
    private func defaultViewCellConfig(_ cell: UICollectionViewCell) {
        
    }
}
