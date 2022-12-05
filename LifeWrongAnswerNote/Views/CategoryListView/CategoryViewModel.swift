//
//  CategoryViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import Foundation

struct CategoryViewModel {
    private let category: Category
    
    var name: String {
        category.name ?? ""
    }
    
    var numberOfProblems: Int {
        category.problems?.count ?? 0
    }
}
