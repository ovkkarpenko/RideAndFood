//
//  ICoreDataManager.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import CoreData

protocol ICoreDataManager {
    
    func addEntity<T: NSManagedObject>(_ type: T.Type, properties: [String: Any])
    
    func fetchEntities(withName name: String,
                       withPredicate predicate: NSPredicate?) -> [NSManagedObject]?
    
    func updateEntity(entityWithName name: String,
                keyedValues: [String: Any],
                predicate: NSPredicate)
    
    func deleteRange(entityName name: String,
                     predicate: NSPredicate)
}
