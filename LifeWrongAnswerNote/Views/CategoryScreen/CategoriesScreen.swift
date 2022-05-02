//
//  CategoryScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/01.
//

import SwiftUI

struct CategoriesScreen: View {
    @State private var searchText = ""
    @State var categories = ["카테고리 1", "카테고리 2"]
    @State var newCategoryName = ""
    @State var emptyNameAlertPresented = false
    @State var alreadySameNameAlertPresented = false
    @ObservedObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CustomSearchBar(searchText: $searchText, placeholder: "카테고리명으로 검색")
                List {
                    ForEach(categoriesVM.categoryVMs, id: \.id) { categoryVM in
                        Text(categoryVM.name)
                    }.onDelete(perform: deleteCategory(at:))
                }
                Spacer()
            }
            .navigationTitle("카테고리 관리")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 23)
            .padding(.horizontal, 16)
            .onAppear(perform: {
                categoriesVM.showAllCategories()
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AlertUtils.displayAlertView(title: "새 카테고리 추가", message: "새로 추가할 카테고리의 이름을 입력하세요.", placeholder: "카테고리 이름 입력") {
                            self.newCategoryName = AlertUtils.alertTextInput
                            if newCategoryName.isEmpty {
                                emptyNameAlertPresented = true
                                return
                            }
                            
                            if Category.byName(name: newCategoryName) != nil {
                                alreadySameNameAlertPresented = true
                                return
                            }
                            
                            categoriesVM.addCategory(name: newCategoryName)
                            categoriesVM.showAllCategories()
                        }
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .alert("카테고리 이름 입력 없음", isPresented: $emptyNameAlertPresented) {
                Text("")
            } message: {
                Text("카테고리 이름을 입력하세요!")
            }
            .alert("중복된 이름 입력", isPresented: $alreadySameNameAlertPresented) {
                Text("")
            } message: {
                Text("이미 해당 이름의 카테고리가 존재합니다.")
            }
        }
    }
    
    private func deleteCategory(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let categoryVM = categoriesVM.categoryVMs[index]
            categoriesVM.deleteCategory(categoryVM: categoryVM)
            categoriesVM.showAllCategories()
        }
    }
}

struct CategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesScreen()
    }
}
