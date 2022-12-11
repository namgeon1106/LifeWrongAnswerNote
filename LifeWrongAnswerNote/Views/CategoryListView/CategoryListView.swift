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
                
                if categoryListVM.categoryVMs.isEmpty {
                    VStack {
                        Spacer()
                        Text(categoryListVM.searchText.isEmpty ?
                             "카테고리가 존재하지 않습니다." : "검색어에 해당하는 카테고리가 존재하지 않습니다.")
                            .padding(.bottom, 100)
                        Spacer()
                    }
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(categoryListVM.enumeratedCategoryVMs, id: \.0) { index, categoryVM in
                                CategoryRow(categoryVM: categoryVM, onModify: {
                                    categoryListVM.alertAndModifyCategory(at: index)
                                }, onDelete: {
                                    categoryListVM.alertAndDeleteCategory(at: index)
                                })
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                }
            }
            .navigationTitle("카테고리 관리")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        categoryListVM.addCategoryAlertIsPresented = true
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
        .onAppear {
            categoryListVM.showAllCategories()
        }
        .modifier(categoryListVM.addCategoryAlert(presented: $categoryListVM.addCategoryAlertIsPresented))
        .modifier(categoryListVM.modifyCategoryAlert(presented: $categoryListVM.modifyNameAlertIsPresented))
        .modifier(categoryListVM.deleteCategoryAlert(presented: $categoryListVM.deleteAlertIsPresented))
        .alert("에러 발생", isPresented: $categoryListVM.errorAlertIsPresented, actions: {
            Button("확인") {
                categoryListVM.errorAlertIsPresented = false
            }
        }, message: {
            Text(categoryListVM.errorMessage)
        })
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
