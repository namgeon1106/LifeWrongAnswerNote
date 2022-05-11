//
//  CategoryListScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/11.
//

import SwiftUI

struct CategoryListScreen: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                CustomSearchBar(searchText: $searchText, placeholder: "이름으로 검색")
                
                ScrollView {
                    VStack {
                        CategoryRow(title: "카테고리 1", count: 9, modifyAction: {}, deleteAction: {})
                        CategoryRow(title: "카테고리 2", count: 5, modifyAction: {}, deleteAction: {})
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
                        
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

struct CategoryListScreen_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListScreen()
    }
}
