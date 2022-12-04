//
//  Category+.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/04.
//

import Foundation

extension Category {
    static func by(name: String) throws -> Category? {
        let request = Category.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Category.name), name)
        
        return try viewContext.fetch(request).first
    }
    
    static func by(searchText: String) throws -> [Category] {
        let request = Category.fetchRequest()
        
        if !searchText.isEmpty {
            request.predicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Category.name), searchText)
        }
        
        return try viewContext.fetch(request)
    }
}
