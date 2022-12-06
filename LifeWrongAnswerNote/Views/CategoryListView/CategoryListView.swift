//
//  CategoryListView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import SwiftUI

struct CategoryListView: View {
    @StateObject private var categoryListVM = CategoryListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                CustomSearchBar(searchText: $categoryListVM.searchText, placeholder: "제목으로 검색")
                    .padding(.horizontal, 16)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(categoryListVM.categoryVMs) { categoryVM in
                            CategoryRow(categoryVM: categoryVM, onModify: {}, onDelete: {})
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("카테고리 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        categoryListVM.addCategories(named: "categoryEx")
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
