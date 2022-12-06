//
//  CategoryViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import Foundation
import CoreData

struct CategoryViewModel: Identifiable {
    private let category: Category
    
    init(category: Category) {
        self.category = category
    }
    
    var id: NSManagedObjectID {
        category.objectID
    }
    
    var name: String {
        category.name ?? ""
    }
    
    var numberOfProblems: Int {
        category.problems?.count ?? 0
    }
}
