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
                                    categoryListVM.modifyingIndex = index
                                    categoryListVM.modifyNameAlertIsPresented = true
                                }, onDelete: {
                                    categoryListVM.deletingIndex = index
                                    categoryListVM.deleteAlertIsPresented = true
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
        .alert("카테고리 추가", isPresented: $categoryListVM.addCategoryAlertIsPresented, actions: {
            TextField("이름 입력", text: $categoryListVM.newCategoryName)
            Button("추가") {
                categoryListVM.addCategoryAlertIsPresented = false
                categoryListVM.addCategory()
            }
            
            Button("취소", role: .cancel) {
                categoryListVM.addCategoryAlertIsPresented = false
            }
        }, message: {
            Text("새롭게 추가할 카테고리의 이름을 입력하세요.")
        })
        .alert("에러 발생", isPresented: $categoryListVM.errorAlertIsPresented, actions: {
            Button("확인") {
                categoryListVM.errorAlertIsPresented = false
            }
        }, message: {
            Text(categoryListVM.errorMessage)
        })
        .alert("카테고리 이름 수정", isPresented: $categoryListVM.modifyNameAlertIsPresented, actions: {
            TextField("이름 입력", text: $categoryListVM.modifiedCategoryName)
            
            Button("취소", role: .cancel) {
                categoryListVM.modifyNameAlertIsPresented = false
            }
            
            Button("수정") {
                categoryListVM.modifyNameAlertIsPresented = false
                categoryListVM.modifyName()
            }
        }, message: {
            Text("카테고리의 새 이름을 입력하세요.")
        })
        .alert("카테고리 제거", isPresented: $categoryListVM.deleteAlertIsPresented, actions: {
            Button("취소", role: .cancel, action: {
                categoryListVM.modifyNameAlertIsPresented = false
            })
            
            Button("제거", role: .destructive) {
                categoryListVM.modifyNameAlertIsPresented = false
                categoryListVM.deleteCategory()
            }
        }, message: {
            Text("정말로 카테고리를 삭제하시겠습니까?")
        })
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
