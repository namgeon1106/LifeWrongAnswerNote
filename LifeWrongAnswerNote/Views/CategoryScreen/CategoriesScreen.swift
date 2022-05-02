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
    @State var failedAlertPresented = false
    @ObservedObject var categoriesVM = CategoriesViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                CustomSearchBar(searchText: $searchText, placeholder: "카테고리명으로 검색")
                List {
                    ForEach(categoriesVM.categoryVMs, id: \.id) { categoryVM in
                        Text(categoryVM.name)
                    }
                }
                Spacer()
            }
            .navigationTitle("카테고리 관리")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.top, 23)
            .padding(.horizontal, 16)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        AlertUtils.displayAlertView(title: "새 카테고리 추가", message: "새로 추가할 카테고리의 이름을 입력하세요.", placeholder: "카테고리 이름 입력") {
                            self.newCategoryName = AlertUtils.alertTextInput
                            if newCategoryName.isEmpty {
                                print("이름을 입력하세요!")
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
        }
        
    }
}

struct CategoryScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesScreen()
    }
}
