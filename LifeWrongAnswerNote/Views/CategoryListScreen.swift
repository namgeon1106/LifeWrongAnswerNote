//
//  CategoryListScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/11.
//

import SwiftUI

struct CategoryListScreen: View {
    @StateObject private var categoryListVM = CategoryListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                CustomSearchBar(searchText: $categoryListVM.searchText, placeholder: "이름으로 검색")
                    .onChange(of: categoryListVM.searchText, perform: categoryListVM.showFilteredCategories(searchText:))
                ScrollView {
                    VStack {
                        ForEach(categoryListVM.categoryVMs, id: \.id) { categoryVM in
                            CategoryRow(title: categoryVM.name, count: categoryVM.count) {
                                categoryListVM.alertAndModify(categoryVM: categoryVM)
                            } deleteAction: {
                                categoryListVM.alertAndDelete(categoryVM: categoryVM)
                            }

                        }
                    }
                }
                
                Spacer()
            }
            .padding(.vertical, 23)
            .padding(.horizontal, 16)
            .navigationTitle("카테고리 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        categoryListVM.alertAndAdd()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
            .onAppear {
                categoryListVM.showAllCategories()
            }
        }
    }
}

struct CategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListScreen()
    }
}
