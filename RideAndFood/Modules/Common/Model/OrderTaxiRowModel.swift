//
//  OrderTaxiModel.swift
//  RideAndFood
//
//  Created by Лаура Есаян on 07.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import Foundation

struct OrderTaxiModelHandler {
    static var shared = OrderTaxiModelHandler()
    
    private var coreDataManager = CoreDataManager.shared
    
    private let entityName = "TaxiOrderDB"
    
    func getTaxiOrder() -> OrderTaxiRowModel? {
        let taxiOrderRows = coreDataManager.fetchEntities(withName: entityName) as? [TaxiOrderDB]
        let orderTaxiRowModel = taxiOrderRows?.compactMap { OrderTaxiRowModel(db: $0) }
        return orderTaxiRowModel?.last ?? nil
    }
    
    func addToTaxiOrder(order: OrderTaxiModel) {
        if let id = order.id {
            if let taxiOrderToUpdate = coreDataManager.fetchEntities(withName: entityName, withPredicate: NSPredicate(format: "id == %d", id))?.first as? TaxiOrderDB {
                coreDataManager.updateEntity(entityWithName: entityName,
                                             keyedValues: ["from": order.from ?? "", "to": order.to ?? ""],
                                             predicate: NSPredicate(format: "id == %d", taxiOrderToUpdate.id))
            } else {
                coreDataManager.addEntity(TaxiOrderDB.self, properties: [
                    "id": Int64(id),
                    "from": order.from ?? "",
                    "to": order.to ?? ""
                ])
            }
        }
    }
    
    func removeTaxiOrder(withId id: Int) {
        coreDataManager.deleteRange(entityName: entityName,
                                    predicate: NSPredicate(format: "id == %d",
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

struct OrderTaxiModel {
    var id: Int?
    var user_id: Int?
    var from: String?
    var to: String?
    var credit: Int?
    var distance: Int?
    var price: Int?
    var discount: Int?
    // describe whole model if needed
}
