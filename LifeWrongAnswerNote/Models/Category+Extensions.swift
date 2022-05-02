//
//  Category+Extensions.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/02.
//

import Foundation

extension Category: BaseModel {
    func rename(newName: String) {
        self.name = newName
        self.save()
    }
}
