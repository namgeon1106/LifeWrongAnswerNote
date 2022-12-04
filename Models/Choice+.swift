//
//  Choice+.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/04.
//

import Foundation

extension Choice {
    static func by(problem: Problem) throws -> [Choice] {
        let request = Choice.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Choice.problem), problem.objectID)
        
        return try CoreDataManager.shared.viewContext.fetch(request)
    }
}
