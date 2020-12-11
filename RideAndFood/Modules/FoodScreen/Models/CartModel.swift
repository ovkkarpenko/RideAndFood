//
//  CartModel.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct CartModel {
    
    static var shared = CartModel()
    
    private var coreDataManager = CoreDataManager.shared
    
    private let entityName = "CartRowDB"
    
    var observers: [ICartChangesObserver] = []
    
    static func getCart() -> Cart {
        let cartRows = CoreDataManager.shared.fetchEntities(withName: "CartRowDB") as? [CartRowDB]
        let cartRowModels = cartRows?.compactMap { CartRowModel(db: $0) }
        let shop = (CoreDataManager.shared.fetchEntities(withName: "ShopDB") as? [ShopDB])?.first
        let shopId = Int(shop?.shopId ?? -1)
        return Cart(rows: cartRowModels ?? [],
                    shopId: shopId == -1 ? nil : shopId,
                    shopName: shop?.shopName)
    }
    
    func addToCart(product: ProductDetailModel, count: Int) {
        if (CoreDataManager.shared.fetchEntities(withName: "ShopDB") as? [ShopDB])?.first == nil {
            coreDataManager.addEntity(ShopDB.self, properties: [
                "shopId": Int16(product.shop.id),
                "shopName": product.shop.name
            ])
        }
        if let cardToUpdate = coreDataManager.fetchEntities(withName: entityName,
                                                            withPredicate: NSPredicate(format: "productId == %d",
                                                                                       product.id))?.first as? CartRowDB {
            coreDataManager.updateEntity(entityWithName: entityName,
                                         keyedValues: ["count": (cardToUpdate.count + Int16(count))],
                                         predicate: NSPredicate(format: "productId == %d", cardToUpdate.productId)) {
                observers.forEach { $0.cartUpdated() }
            }
        } else {
            coreDataManager.addEntity(CartRowDB.self, properties: [
                "productId": Int16(product.id),
                "productName": product.name,
                "productPrice": Float(product.price),
                "count": Int16(count)
            ]) {
                observers.forEach { $0.cartUpdated() }
            }
        }
    }
    
    func removeFromCartProduct(withId id: Int) {
        coreDataManager.deleteRange(entityName: entityName,
                                    predicate: NSPredicate(format: "productId == %@",
                                                           id)) {
            if (CoreDataManager.shared.fetchEntities(withName: "CartRowDB") as? [CartRowDB])?.count == 0 {
                self.emptyCart()
            } else {
                self.observers.forEach { $0.cartUpdated() }
            }
        }
    }
    
    func emptyCart() {
        CoreDataManager.shared.deleteRange(entityName: "ShopDB") {
            CoreDataManager.shared.deleteRange(entityName: "CartRowDB") {
                self.observers.forEach { $0.cartUpdated() }
            }
        }
    }
}

struct CartRowModel {
    let productId: Int
    let productName: String
    let productPrice: Float
    let productPriceString: String
    let count: Int
    var sum: Float {
        productPrice * Float(count)
    }
    
    init?(db: CartRowDB) {
        guard let name = db.productName else { return nil }
        
        self.productId = Int(db.productId)
        self.productName = name
        self.productPrice = db.productPrice
        self.productPriceString = db.productPrice.currencyString()
        self.count = Int(db.count)
    }
}

protocol ICartChangesObserver {
    func cartUpdated()
}
