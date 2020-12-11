//
//  OrderTaxiModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct OrderTaxiModelHandler {
    private var coreDataManager = CoreDataManager.shared
    
    private let entityName = "TaxiOrderDB"
    
    func getTaxiOrder() -> OrderTaxiRowModel? {
        let taxiOrders = coreDataManager.fetchEntities(withName: entityName) as? [TaxiOrderDB]
        let orderTaxiModel = taxiOrders?.compactMap { OrderTaxiRowModel(db: $0) }
        return orderTaxiModel?.last ?? nil
    }
    
    func addToTaxiOrder(order: OrderTaxiRowModel) {
        if let taxiOrderToUpdate = coreDataManager.fetchEntities(withName: entityName, withPredicate: NSPredicate(format: "id == %d", order.id))?.first as? TaxiOrderDB {
            coreDataManager.updateEntity(entityWithName: entityName,
                                         keyedValues: ["from": order.from, "to": order.to],
                                         predicate: NSPredicate(format: "id == %d", taxiOrderToUpdate.id))
        } else {
            coreDataManager.addEntity(TaxiOrderDB.self, properties: [
                "id": Int64(order.id),
                "from": order.from,
                "to": order.to
            ])
        }
    }
    
    func removeTaxiOrder(withId id: Int) {
        coreDataManager.deleteRange(entityName: entityName,
                                    predicate: NSPredicate(format: "id == %@",
                                                           id))
    }
}

struct OrderTaxiRowModel {
    let id: Int
    let from: String
    let to: String
    
    init?(db: TaxiOrderDB) {
        self.id = Int(db.id)
        self.from = db.from ?? ""
        self.to = db.to ?? ""
    }
}
