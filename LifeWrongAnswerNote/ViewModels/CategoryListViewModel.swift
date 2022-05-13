//
//  CategoryListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/13.
//

import Foundation
import CoreData

class CategoryListViewModel: ObservableObject {
    @Published var categoryVMs = [CategoryViewModel]()
    
    func showAllCategories() {
        self.categoryVMs = Category.all().map(CategoryViewModel.init(category:))
    }
    
    func showFilteredCategories(searchText: String) {
        self.categoryVMs = Category.filteredBy(searchText).map(CategoryViewModel.init(category:))
    }
    
    func addCategory(name: String) {
        let category = Category(context: Category.viewContext)
        category.name = name
        category.problems = []
        CoreDataManager.shared.save()
    }
    
    func renameCategory(categoryVM: CategoryViewModel, newName: String) {
        categoryVM.category.rename(newName: newName)
    }
    
    func deleteCategory(categoryVM: CategoryViewModel) {
        categoryVM.category.delete()
        CoreDataManager.shared.save()
    }
}

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
