//
//  Problem+.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/04.
//

import Foundation

extension Problem {
    static func by(category: Category?, isFinished: Bool?, searchText: String) throws -> [Problem] {
        let request = Problem.fetchRequest()
        var predicates = [NSPredicate]()
        
        if let category {
            let categoryPredicate = NSPredicate(format: "%K = %@", #keyPath(Problem.category), category.objectID)
            predicates.append(categoryPredicate)
        }
        
        if let isFinished {
            let finishedPredicate = NSPredicate(format: "%K = %i", #keyPath(Problem.finished), isFinished)
            predicates.append(finishedPredicate)
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        return try viewContext.fetch(request)
    }
}
