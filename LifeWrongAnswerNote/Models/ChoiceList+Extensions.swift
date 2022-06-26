//
//  ChoiceList+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/06/26.
//

import Foundation

extension ChoiceList: BaseModel {
    static func byProblem(problem: Problem) -> ChoiceList? {
        let request = ChoiceList.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(ChoiceList.problem), problem.objectID)
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(request).first
        } catch {
            return nil
        }
    }
}
