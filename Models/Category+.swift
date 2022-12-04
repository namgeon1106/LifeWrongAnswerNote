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
        
        return try Self.viewContext.fetch(request).first
    }
}