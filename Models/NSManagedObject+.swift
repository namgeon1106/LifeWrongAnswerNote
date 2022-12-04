//
//  BaseModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/04.
//

import Foundation
import CoreData

extension NSManagedObject {
    static var viewContext: NSManagedObjectContext {
        return CoreDataManager.shared.viewContext
    }
    
    func delete() {
        Self.viewContext.delete(self)
    }
}

// https://www.udemy.com/course/core-data-in-ios/
