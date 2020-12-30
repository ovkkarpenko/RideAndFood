//
//  OrderFoodModelHandler.swift
//  RideAndFood
//
//  Created by Laura Esaian on 29.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct OrderFoodModelHandler {
    static var shared = OrderFoodModelHandler()
    
    private var coreDataManager = CoreDataManager.shared
    
    private let entityName = "FoodOrderDB"
    
    func getFoodOrder() -> OrderFoodRowModel? {
        let foodOrderRows = coreDataManager.fetchEntities(withName: entityName) as? [FoodOrderDB]
        let orderFoodRowModel = foodOrderRows?.compactMap { OrderFoodRowModel(db: $0) }
        return orderFoodRowModel?.last ?? nil
    }

    func addToFoodOrder(order: OrderFoodModel) {
        if let id = order.id {
            if let foodOrderToUpdate = coreDataManager.fetchEntities(withName: entityName, withPredicate: NSPredicate(format: "id == %d", id))?.first as? FoodOrderDB {
                coreDataManager.updateEntity(entityWithName: entityName,
                                             keyedValues: ["fromAddress": order.from ?? foodOrderToUpdate.fromAddress ?? "",
                                                           "toAddress": order.to ?? foodOrderToUpdate.toAddress ?? "",
                                                           "courierName": order.courierName ?? foodOrderToUpdate.courierName ?? "",
                                                           "courierNumber": order.courierNumber ?? foodOrderToUpdate.courierNumber ?? "",
                                                           "time": order.time ?? foodOrderToUpdate.time,
                                                           "toAddressName": order.toName ?? foodOrderToUpdate.toAddressName ?? ""],
                                             predicate: NSPredicate(format: "id == %d", foodOrderToUpdate.id))
            } else {
                coreDataManager.addEntity(FoodOrderDB.self, properties: [
                    "id": Int64(id),
                    "fromAddress": order.from ?? "",
                    "toAddress": order.to ?? "",
                    "courierName": order.courierName ?? "",
                    "courierNumber": order.courierNumber ?? "",
                    "time": Int64(order.time ?? 0),
                    "toAddressName": order.toName ?? ""
                ])
            }
        }
    }

    func removeFoodOrder(withId id: Int) {
        coreDataManager.deleteRange(entityName: entityName,
                                    predicate: NSPredicate(format: "id == %d",
                                                           id))
    }
    
    func deleteAllFoodOrders() {
        let foodOrderRows = coreDataManager.fetchEntities(withName: entityName) as? [FoodOrderDB]
        let orderFoodRowModel = foodOrderRows?.compactMap { OrderFoodRowModel(db: $0) }
        
        for row in orderFoodRowModel! {
            removeFoodOrder(withId: row.id)
        }
    }
}

struct OrderFoodRowModel {
    let id: Int
    let from: String
    let to: String
    let toName: String
    let courierName: String
    let courierNumber: String
    let time: Int
    
    init?(db: FoodOrderDB) {
        self.id = Int(db.id)
        self.from = db.fromAddress ?? ""
        self.to = db.toAddress ?? ""
        self.toName = db.toAddressName ?? ""
        self.courierName = db.courierName ?? ""
        self.courierNumber = db.courierNumber ?? ""
        self.time = Int(db.time)
    }
}

struct OrderFoodModel {
    var id: Int?
    var user_id: Int?
    var from: String?
    var to: String?
    var toName: String?
    var credit: Int?
    var distance: Int?
    var price: Int?
    var discount: Int?
    var time: Int?
    var courierName: String?
    var courierNumber: String?
    // describe whole model if needed
}
