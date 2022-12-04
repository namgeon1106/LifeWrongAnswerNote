//
//  Problem+.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/04.
//

import Foundation

extension Problem {
    var assessment: Assessment {
        get {
            .notSure
        }
        
        set {
            
        }
    }
    
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
        
        if !searchText.isEmpty {
            let searchTextPredicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Problem.title), searchText)
            predicates.append(searchTextPredicate)
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        return try viewContext.fetch(request)
    }
}
