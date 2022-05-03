//
//  Problem+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/03.
//

import Foundation

extension Problem: BaseModel {
    func setValues(title: String, category: Category, assessment: Assessment, situation: String, choices: [Choice], reason: String, result: String, retrospection: String) {
        self.title = title
        self.assessment = assessment.rawValue
        self.situation = situation
        self.choices = []
        self.choices?.addingObjects(from: choices)
        self.reason = reason
        self.result = result
        self.retrospection = retrospection
        
        self.save()
    }
}
