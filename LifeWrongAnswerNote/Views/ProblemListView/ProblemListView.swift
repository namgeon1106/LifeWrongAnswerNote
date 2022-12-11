//
//  ProblemListView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct ProblemListView: View {
    @StateObject private var problemListVM = ProblemListViewModel()
    @StateObject private var categoryListVM = CategoryListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 18) {
                HStack(spacing: 16) {
                    MenuLabel(isClickable: true) {
                        Text("카테고리")
                            .font(.system(size: 14))
                    }
                    MenuLabel(isClickable: true) {
                        Text("진행상태")
                            .font(.system(size: 14))
                    }
                    Spacer()
                }
                .padding(.horizontal, 16)
                
                CustomSearchBar(searchText: $problemListVM.searchText, placeholder: "제목으로 검색")
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(problemListVM.enumeratedProblemVMs, id: \.0) { index, problemVM in
                            ProblemRow(problemVM: problemVM)
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("문제 목록")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                problemListVM.showFilteredProblems()
                categoryListVM.showAllCategories()
            }
        }
    }
}

struct ProblemListView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListView()
    }
}
