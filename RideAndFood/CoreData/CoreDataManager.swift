//
//  CoreDataManager.swift
//  RideAndFood
//
//  Created by Nikita Gundorin on 02.12.2020.
//  Copyright © 2020 skillbox. All rights reserved.
//

import CoreData

class CoreDataManager: ICoreDataManager {
    
    // MARK: - Singleton
    
    static let shared = CoreDataManager()
    private init() {}
    
    // MARK: - Private Properties
    
    private let dataBaseName = "RideAndFood"
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: dataBaseName)
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("something went wrong: \(error)")
            }
        }
        return container
    }()
    
    // MARK: - ICoreDataManager
    
    func addEntity<T: NSManagedObject>(_ type: T.Type,
                                       properties: [String: Any],
                                       completion: (() -> Void)? = nil) {
        performSave { context in
            guard let entity = NSEntityDescription.entity(forEntityName: T.description(), in: context) else { return }
            let record = T(entity: entity, insertInto: context)
            record.initialize(with: properties)
        } completion: {
            completion?()
        }
    }
    
    func fetchEntities(withName name: String,
                       withPredicate predicate: NSPredicate? = nil) -> [NSManagedObject]? {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: name)
        fetchRequest.predicate = predicate
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return result
        } catch {
            print(error)
        }
        return nil
    }
    
    func updateEntity(entityWithName name: String,
                      keyedValues: [String: Any],
                      predicate: NSPredicate,
                      completion: (() -> Void)? = nil) {
        performSave { context in
            let request = NSFetchRequest<NSManagedObject>(entityName: name)
            request.predicate = predicate
            if let objectToUpdate = try? context.fetch(request).first {
                objectToUpdate.setValuesForKeys(keyedValues)
            }
        } completion: {
            completion?()
        }
    }
    
    func deleteRange(entityName name: String,
                     predicate: NSPredicate? = nil,
                     completion: (() -> Void)? = nil) {
        performSave { context in
            let request = NSFetchRequest<NSManagedObject>(entityName: name)
            request.predicate = predicate
            if let objectsToDelete = try? context.fetch(request), objectsToDelete.count > 0 {
                objectsToDelete.forEach {
                    context.delete($0)
                }
            }
        } completion: {
            completion?()
        }
    }
    
    // MARK: - Private methods
    
    private func performSave(block: @escaping (NSManagedObjectContext) -> Void,
                             completion: (() -> Void)? = nil) {
        container.performBackgroundTask { context in
            block(context)
            
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    print(error)
                    completion?()
                }
            }
            completion?()
        }
    }
}
