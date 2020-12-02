//
//  CartModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CartModel {
    
    private var coreDataManager = CoreDataManager.shared
    
    private let entityName = "CartRowDB"
    
    func getCart() -> ([CartRowModel], Int) {
        let cartRows = coreDataManager.fetchEntities(withName: entityName) as? [CartRowDB]
        let cartRowModels = cartRows?.compactMap { CartRowModel(db: $0) }
        return (cartRowModels ?? [], cartRows?.count ?? 0)
    }
    
    func addToCart(product: ProductDetailModel, count: Int) {
        if let cardToUpdate = coreDataManager.fetchEntities(withName: entityName,
                                                            withPredicate: NSPredicate(format: "productId == %d",
                                                                                       product.id))?.first as? CartRowDB {
            coreDataManager.updateEntity(entityWithName: entityName,
                                         keyedValues: ["count": (cardToUpdate.count + Int16(count))],
                                         predicate: NSPredicate(format: "productId == %d", cardToUpdate.productId))
        } else {
            coreDataManager.addEntity(CartRowDB.self, properties: [
                "productId": Int16(product.id),
                "productName": product.name,
                "productPrice": Float(product.price),
                "count": Int16(count)
            ])
        }
    }
    
    func removeFromCartProduct(withId id: Int) {
        coreDataManager.deleteRange(entityName: entityName,
                                    predicate: NSPredicate(format: "productId == %@",
                                                           id))
    }
}

struct CartRowModel {
    let productId: Int
    let productName: String
    let productPrice: String
    let count: Int
    
    init?(db: CartRowDB) {
        guard let name = db.productName else { return nil }
        
        self.productId = Int(db.productId)
        self.productName = name
        self.productPrice = "\(db.productPrice) \(StringsHelper.rub.text())"
        self.count = Int(db.count)
    }
}
