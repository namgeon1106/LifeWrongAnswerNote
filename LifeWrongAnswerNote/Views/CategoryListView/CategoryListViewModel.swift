//
//  CategoryListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/06.
//

import Foundation
import SwiftUI

class CategoryListViewModel: ObservableObject {
    @Published var categoryVMs = [CategoryViewModel]()
    var enumeratedCategoryVMs: [(Int, CategoryViewModel)] {
        Array(categoryVMs.enumerated())
    }
    
    @Published var newCategoryName = ""
    @Published var addCategoryAlertIsPresented = false {
        didSet {
            if addCategoryAlertIsPresented {
                newCategoryName = ""
            }
        }
    }
    
    @Published var searchText = "" {
        didSet {
            showFilteredCategories()
        }
    }
    
    @Published var errorAlertIsPresented = false
    @Published var errorMessage = "" {
        didSet {
            errorAlertIsPresented = true
        }
    }
    
    // MARK: - 수정 alert
    private var modifyingIndex = 0
    @Published var modifiedCategoryName = ""
    @Published var modifyNameAlertIsPresented = false {
        didSet {
            if modifyNameAlertIsPresented {
                modifiedCategoryName = ""
            }
        }
    }
    
    private func modifyCategory(at index: Int, to newName: String) {
        do {
            if try Category.by(name: newName) != nil {
                throw NSError()
            }
            
            try categoryVMs[index].modifyName(to: newName)
        } catch {
            errorMessage = "카테고리 이름을 수정하는데 실패했습니다."
            CoreDataManager.shared.viewContext.rollback()
        }
    }
    
    func modifyCategoryAlert(presented: Binding<Bool>) -> AlertModifierWithTextField {
        return AlertModifierWithTextField(presented: presented,
                                          title: "카테고리 수정",
                                          message: "카테고리의 새 이름을 입력하세요.",
                                          okMessage: "수정") { input in
            self.modifyCategory(at: self.modifyingIndex, to: input)
        }
    }
    
    func alertAndModifyCategory(at index: Int) {
        modifyingIndex = index
        modifyNameAlertIsPresented = true
    }
    
    var deletingIndex = 0
    @Published var deleteAlertIsPresented = false
    
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
    
    func addCategory() {
        do {
            let newCategory = Category(context: CoreDataManager.shared.viewContext)
            newCategory.name = newCategoryName
            
            try CoreDataManager.shared.viewContext.save()
            showFilteredCategories()
        } catch {
            errorMessage = "카테고리를 추가하는데 실패하였습니다."
            CoreDataManager.shared.viewContext.rollback()
        }
    }
    
    func deleteCategory() {
        do {
            try categoryVMs[deletingIndex].delete()
            categoryVMs.remove(at: deletingIndex)
        } catch {
            errorMessage = "카테고리를 제거하는데 실패했습니다."
            CoreDataManager.shared.viewContext.rollback()
        }
    }
}
