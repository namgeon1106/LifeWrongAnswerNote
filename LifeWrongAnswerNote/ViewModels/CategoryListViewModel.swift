//
//  CategoryListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/13.
//

import Foundation
import CoreData

struct CategoryViewModel {
    let category: Category
    
    var id: NSManagedObjectID {
        category.objectID
    }
    
    var name: String {
        category.name ?? ""
    }
    
    var count: Int {
        category.problems!.count
    }
}
