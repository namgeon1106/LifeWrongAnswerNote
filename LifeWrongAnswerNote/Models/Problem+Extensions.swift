//
//  Problem+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/18.
//

import Foundation

extension Problem: BaseModel {
    static func by(category: Category?, finished: Bool?, searchText: String) -> [Problem] {
        var predicates = [NSPredicate]()
                
        if let category = category {
            let categoryPredicate = NSPredicate(format: "%K = %@", #keyPath(Problem.category), category.objectID)
            predicates.append(categoryPredicate)
        }
        
        if let finished = finished {
            let finishedPredicate = NSPredicate(format: "%K = %i", #keyPath(Problem.finished), finished)
            predicates.append(finishedPredicate)
        }
        
        if !searchText.isEmpty {
            let searchTextPredicate = NSPredicate(format: "%K CONTAINS %@", #keyPath(Problem.title), searchText)
            predicates.append(searchTextPredicate)
        }
        
        let request = Problem.fetchRequest()
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
