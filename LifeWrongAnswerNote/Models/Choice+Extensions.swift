//
//  Choice+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/04.
//

import Foundation
import CoreData

extension Choice: BaseModel {
    static func getChoicesByProblemId(problemId: NSManagedObjectID) -> [Choice] {
        let request = Choice.fetchRequest()
        request.predicate = NSPredicate(format: "problem = %@", problemId)
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
