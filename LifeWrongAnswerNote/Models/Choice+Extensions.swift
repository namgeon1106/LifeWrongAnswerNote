//
//  Choice+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/06/26.
//

import Foundation
import CoreData

extension Choice: BaseModel {
    static func byChoiceList(_ choiceList: ChoiceList) -> [Choice] {
        let request = Choice.fetchRequest()
        request.predicate = NSPredicate(format: "%K = %@", #keyPath(Choice.choiceList), choiceList.objectID)
        
        do {
            return try CoreDataManager.shared.viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
