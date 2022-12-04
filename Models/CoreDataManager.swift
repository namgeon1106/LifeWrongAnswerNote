//
//  CoreDataManager.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/03.
//

import Foundation
import CoreData

class CoreDataManager {
    private let container: NSPersistentContainer
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private init() {
        container = NSPersistentContainer(name: "ProblemModel")
    }
    
    func load(forTest: Bool) {
        if forTest {
            let description = NSPersistentStoreDescription()
            if #available(iOS 16.0, *) {
                description.url = URL(filePath: "/dev/null")
            } else {
                description.url = URL(fileURLWithPath: "/dev/null")
            }
            
            container.persistentStoreDescriptions = [description]
        }
        
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Failed to initialize Core Data: \(error)")
            }
        }
    }
}
