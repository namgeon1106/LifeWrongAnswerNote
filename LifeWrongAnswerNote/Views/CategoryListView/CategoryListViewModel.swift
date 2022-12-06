//
//  CategoryListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/06.
//

import Foundation

class CategoryListViewModel: ObservableObject {
    @Published var categoryVMs = [CategoryViewModel]()
    var enumeratedCategoryVMs: [(Int, CategoryViewModel)] {
        Array(categoryVMs.enumerated())
    }
    
    @Published var errorAlertIsPresented = false
    
    var modifyingIndex = 0
    @Published var modifiedCategoryName = ""
    @Published var modifyNameAlertIsPresented = false {
        didSet {
            if modifyNameAlertIsPresented {
                modifiedCategoryName = ""
            }
        }
    }
    
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
            errorMessage = "카테고리를 추가하는데 실패하였습니다."
            CoreDataManager.shared.viewContext.rollback()
        }
    }
    
    func modifyName() {
        do {
            if try Category.by(name: modifiedCategoryName) != nil {
                errorMessage = "이미 같은 이름의 카테고리가 존재합니다."
                return
            }
            
            try categoryVMs[modifyingIndex].modifyName(to: modifiedCategoryName)
        } catch {
            errorMessage = "카테고리 이름을 수정하는데 실패했습니다."
            CoreDataManager.shared.viewContext.rollback()
        }
    }
}
