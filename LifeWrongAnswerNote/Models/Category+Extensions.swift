//
//  Category+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/13.
//

import Foundation
import CoreData

extension Category: BaseModel {
    func rename(newName: String) {
        self.name = newName
        CoreDataManager.shared.save()
    }
    
    static func byName(_ name: String) -> Category? {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Category.name), name)
        
        do {
            let categoryArr = try Self.viewContext.fetch(request)
            return categoryArr.isEmpty ? nil : categoryArr[0]
        } catch {
            return nil
        }
    }
    
    static func filteredBy(_ subString: String) -> [Category] {
        if subString.isEmpty {
            return Category.all()
        }
        
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "INSTR(%K, %@) > 0", #keyPath(Category.name), subString)
        
        do {
            return try Self.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
