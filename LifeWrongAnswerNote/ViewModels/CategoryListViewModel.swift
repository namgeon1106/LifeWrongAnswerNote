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
    @Published var searchText = ""
    
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
    
    func alertAndAdd() {
        AlertUtils.displayAlertViewWithTextField(title: "새 카테고리 추가", message: "새로 추가할 카테고리의 이름을 입력하세요.", placeholder: "카테고리 이름 입력", okMessage: "추가", okStyle: .default) {
            let categoryName = AlertUtils.alertTextInput
            
            if Category.byName(categoryName) != nil {
                AlertUtils.displayNotifyingAlertView(title: "카테고리 이름 중복", message: "이미 해당 이름의 카테고리가 존재합니다.", okMessage: "확인", okStyle: .default)
                return
            }
            
            self.addCategory(name: categoryName)
            CoreDataManager.shared.save()
            self.showFilteredCategories(searchText: self.searchText)
        }
    }
    
    func alertAndModify(categoryVM: CategoryViewModel) {
        AlertUtils.displayAlertViewWithTextField(title: "카테고리 이름 변경", message: "카테고리의 새 이름을 입력하세요.", placeholder: "카테고리 이름 입력", okMessage: "변경", okStyle: .default) {
            let categoryName = AlertUtils.alertTextInput
            
            if Category.byName(categoryName) != nil {
                AlertUtils.displayNotifyingAlertView(title: "카테고리 이름 중복", message: "이미 해당 이름의 카테고리가 존재합니다.", okMessage: "확인", okStyle: .default)
                return
            }
            
            self.renameCategory(categoryVM: categoryVM, newName: categoryName)
            CoreDataManager.shared.save()
            self.showFilteredCategories(searchText: self.searchText)
        }
    }
    
    func alertAndDelete(categoryVM: CategoryViewModel) {
        AlertUtils.displayAlertView(title: "카테고리 제거", message: "정말로 해당 카테고리를 제거하시겠습니까?", okMessage: "삭제", okStyle: .destructive) {
            self.deleteCategory(categoryVM: categoryVM)
            CoreDataManager.shared.save()
            self.showFilteredCategories(searchText: self.searchText)
        }
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
