//
//  CategoriesViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/02.
//

import Foundation
import CoreData

class CategoryListViewModel: ObservableObject {
    static var shared = CategoryListViewModel()
    
    private init() {
        
    }
    
    @Published var categoryVMs = [CategoryViewModel]()
    
    func addCategory(name: String) {
        let category = Category(context: Category.viewContext)
        category.name = name
        category.problems = []
        category.save()
    }
    
    func renameCategory(categoryVM: CategoryViewModel, newName: String) {
        let category: Category? = Category.byId(id: categoryVM.id)
        if let category = category {
            category.rename(newName: newName)
        }
    }
    
    func deleteCategory(categoryVM: CategoryViewModel) {
        let category: Category? = Category.byId(id: categoryVM.id)
        if let category = category {
            category.delete()
        }
    }
    
    func getAllCategories() -> [CategoryViewModel] {
        return Category.all().map(CategoryViewModel.init(category:))
    }
    
    func showAllCategories() {
        self.categoryVMs = Category.all().map(CategoryViewModel.init(category:))
    }
    
    func showCategoriesWith(subString: String) {
        if subString.isEmpty {
            showAllCategories()
            return
        }
        
        self.categoryVMs = Category.filteredBy(subString: subString).map(CategoryViewModel.init(category:))
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
}
