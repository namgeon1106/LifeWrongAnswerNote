//
//  CategoryListView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import SwiftUI

struct CategoryListView: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                CustomSearchBar(searchText: $searchText, placeholder: "제목으로 검색")
                    .padding(.horizontal, 16)
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(0..<10) { _ in
                            CategoryRow()
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }

            .navigationTitle("카테고리 관리")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView()
    }
}
