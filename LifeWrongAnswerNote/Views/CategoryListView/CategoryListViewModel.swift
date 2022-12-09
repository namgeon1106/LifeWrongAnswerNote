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
    
    // MARK: - 추가 alert
    @Published var newCategoryName = ""
    @Published var addCategoryAlertIsPresented = false {
        didSet {
            if addCategoryAlertIsPresented {
                newCategoryName = ""
            }
        }
    }
    
    private func addCategory(named name: String) {
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
    
    func addCategoryAlert(presented: Binding<Bool>) -> AlertModifierWithTextField {
        return AlertModifierWithTextField(presented: presented,
                                          title: "카테고리 추가",
                                          message: "새롭게 추가할 카테고리 이름을 입력하세요.",
                                          okMessage: "추가", action: addCategory(named:))
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
    
    // MARK: - 삭제 alert
    private var deletingIndex = 0
    @Published var deleteAlertIsPresented = false
    
    private func deleteCategory(at index: Int) {
        do {
            try categoryVMs[index].delete()
            categoryVMs.remove(at: index)
        } catch {
            errorMessage = "카테고리를 삭제하는데 에러가 발생했습니다."
            CoreDataManager.shared.viewContext.rollback()
        }
    }
    
    func deleteCategoryAlert(presented: Binding<Bool>) -> AlertModifier {
        return AlertModifier(presented: presented,
                             title: "카테고리 삭제",
                             message: "정말로 카테고리를 삭제하시겠습니까?",
                             okMessage: "삭제", okStyle: .destructive) {
            self.deleteCategory(at: self.deletingIndex)
        }
    }
    
    func alertAndDeleteCategory(at index: Int) {
        deletingIndex = index
        deleteAlertIsPresented = true
    }
}
