//
//  OrderTaxiModelHandler.swift
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
    
    func getTaxiOrder() -> OrderTaxiModel? {
        let taxiOrderRows = coreDataManager.fetchEntities(withName: entityName) as? [TaxiOrderDB]
        let orderTaxiRowModel = taxiOrderRows?.compactMap { OrderTaxiModel(db: $0) }
        return orderTaxiRowModel?.last ?? nil
    }
    
    func addToTaxiOrder(order: OrderTaxiModel, conpletion: @escaping () -> Void) {
        let taxiOrders = coreDataManager.fetchEntities(withName: entityName,
                                                              withPredicate: NSPredicate(format: "id == %d",
                                                                                         order.id))
        if let taxiOrderToUpdate = taxiOrders?.first as? TaxiOrderDB {
            coreDataManager.updateEntity(entityWithName: entityName,
                                         keyedValues: ["from": order.from,
                                                       "to": order.to,
                                                       "car": order.car ,
                                                       "color": order.color ,
                                                       "driver": order.driver,
                                                       "price": order.price,
                                                       "carImage": order.carImage,
                                                       "tariffId": order.tariffId,
                                                       "tariffName": order.tariffName],
                                         predicate: NSPredicate(format: "id == %d", taxiOrderToUpdate.id),
                                         completion: conpletion)
        } else {
            coreDataManager.addEntity(TaxiOrderDB.self, properties: [
                "id": order.id,
                "from": order.from,
                "to": order.to,
                "car": order.car,
                "color": order.color,
                "driver": order.driver,
                "price": order.price,
                "carImage": order.carImage,
                "tariffId": order.tariffId,
                "tariffName": order.tariffName
            ], completion: conpletion)
        }
    }
    
    func removeTaxiOrder(withId id: Int) {
        coreDataManager.deleteRange(entityName: entityName,
                                    predicate: NSPredicate(format: "id == %d",
                                                           id))
    }
    
    func finishOrder() {
        if let order = getTaxiOrder() {
            removeTaxiOrder(withId: order.id)
        }
    }
    
    // Mock server data until it is fixed
    func generateOrder(order: TaxiOrder, tariff: TariffModel) -> OrderTaxiModel {
        var id = UserDefaults.standard.integer(forKey: "taxiId")
        if (id < 1) {
            id = 1
        }
        UserDefaults.standard.setValue(id + 1, forKey: "taxiId")
        let price = Int.random(in: 49...999)
        let drivers = ["Анатолий", "Джонни", "Иван", "Боб", "Квентин"]
        let colors = ["Белый", "Черный", "Желтый", "Красный", "Зеленый"]
        let cars = tariff.cars?.components(separatedBy: ", ")
        return .init(id: id,
                     from: order.from,
                     to: order.to,
                     car: cars?.randomElement() ?? "",
                     color: colors.randomElement() ?? "",
                     driver: drivers.randomElement() ?? "",
                     price: Float(price),
                     carImage: tariff.icon ?? "",
                     tariffId: tariff.id ?? 1,
                     tariffName: tariff.name ?? "")
    }
}

struct OrderTaxiModel {
    let id: Int
    let from: String
    let to: String
    let car: String
    let color: String
    let driver: String
    let price: Float
    let carImage: String
    let tariffId: Int
    let tariffName: String
    
    init(id: Int,
         from: String,
         to: String,
         car: String,
         color: String,
         driver: String,
         price: Float,
         carImage: String,
         tariffId: Int,
         tariffName: String) {
        self.id = id
        self.from = from
        self.to = to
        self.car = car
        self.color = color
        self.driver = driver
        self.price = price
        self.carImage = carImage
        self.tariffId = tariffId
        self.tariffName = tariffName
    }
    
    init(db: TaxiOrderDB) {
        self.id = Int(db.id)
        self.from = db.from ?? ""
        self.to = db.to ?? ""
        self.car = db.car ?? ""
        self.color = db.color ?? ""
        self.driver = db.driver ?? ""
        self.price = db.price
        self.carImage = db.carImage ?? ""
        self.tariffId = Int(db.tariffId)
        self.tariffName = db.tariffName ?? ""
    }
}
