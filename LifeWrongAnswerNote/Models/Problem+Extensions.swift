//
//  Problem+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/03.
//

import Foundation

extension Problem: BaseModel {
    func setValues(title: String, category: Category?, assessment: Assessment, situation: String, chosen: Choice?, reason: String, result: String, retrospection: String, date: Date) {
        self.title = title
        self.category = category
        self.assessment = assessment.rawValue
        self.situation = situation
        self.chosen = chosen
        self.reason = reason
        self.result = result
        self.retrospection = retrospection
        self.date = date
        
        self.save()
    }
    
    static func filteredBy(subString: String, category: Category?) -> [Problem] {
        return all().filter { problem in
            (subString.isEmpty ? true : problem.title!.contains(subString))
            && (category != nil ? problem.category == category : true)
        }
    }
}
