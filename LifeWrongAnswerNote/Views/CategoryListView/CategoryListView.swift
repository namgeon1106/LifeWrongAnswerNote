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
                        ForEach(categoryListVM.enumeratedCategoryVMs, id: \.0) { index, categoryVM in
                            CategoryRow(categoryVM: categoryVM, onModify: {
                                categoryListVM.modifyingIndex = index
                                categoryListVM.modifyNameAlertIsPresented = true
                            }, onDelete: {
                                
                            })
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
        .alert("에러 발생", isPresented: $categoryListVM.errorAlertIsPresented, actions: {
            Button("확인") {
                categoryListVM.errorAlertIsPresented = false
            }
        }, message: {
            Text(categoryListVM.errorMessage)
        })
        .alert("카테고리 이름 수정", isPresented: $categoryListVM.modifyNameAlertIsPresented, actions: {
            TextField("이름 입력", text: $categoryListVM.modifiedCategoryName)
            Button("취소", role: .cancel, action: {
                categoryListVM.modifyNameAlertIsPresented = false
            })
            Button("확인", action: {
                categoryListVM.modifyNameAlertIsPresented = false
                categoryListVM.modifyName()
            })
        }, message: {
            Text("카테고리의 새 이름을 입력하세요.")
        })
        .onAppear {
            categoryListVM.showAllCategories()
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
