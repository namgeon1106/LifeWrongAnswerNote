//
//  Category+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/02.
//

import Foundation
import CoreData

extension Category: BaseModel {
    func rename(newName: String) {
        self.name = newName
        self.save()
    }
    
    static func byName(name: String) -> Category? {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "name = %@", name)
        
        do {
            let categoryArr = try Self.viewContext.fetch(request)
            return categoryArr.isEmpty ? nil : categoryArr[0]
        } catch {
            return nil
        }
    }
}
