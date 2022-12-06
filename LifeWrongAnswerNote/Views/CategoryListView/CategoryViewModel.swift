//
//  CategoryViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import Foundation
import CoreData

struct CategoryViewModel: Identifiable {
    private var category: Category
    
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
    
    mutating func modifyName(to newName: String) throws {
        category.name = newName
        
        try CoreDataManager.shared.viewContext.save()
        
        category = try Category.by(id: id) as! Category
    }
    
    func delete() throws {
        category.delete()
        
        try CoreDataManager.shared.viewContext.save()
    }
}
