//
//  CategoryListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/06.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categoryVMs = [CategoryViewModel]()
    @Published var errorAlertIsPresented = false
    
    @Published var searchText = "" {
        didSet {
            showFilteredCategories()
        }
    }
    
    @Published var errorMessage = "" {
        didSet {
            errorAlertIsPresented = true
        }
    }
    
    func showFilteredCategories() {
        do {
            categoryVMs = try Category.by(searchText: searchText).map(CategoryViewModel.init)
        } catch {
            errorMessage = "카테고리들을 불러오는데 에러가 발생했습니다."
        }
    }
    
    func showAllCategories() {
        do {
            categoryVMs = try Category.all().map(CategoryViewModel.init)
        } catch {
            errorMessage = "카테고리들을 불러오는데 에러가 발생했습니다."
        }
    }
    
    func addCategories(named name: String) {
        do {
            let newCategory = Category(context: CoreDataManager.shared.viewContext)
            newCategory.name = name
            
            try CoreDataManager.shared.viewContext.save()
            showFilteredCategories()
        } catch {
            CoreDataManager.shared.viewContext.rollback()
        }
    }
}
