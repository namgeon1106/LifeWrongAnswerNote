//
//  ProblemListScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ProblemListScreen: View {
    @State private var searchText = ""
    @ObservedObject private var problemListVM = ProblemListViewModel.shared
    let categoryListVM = CategoryListViewModel.shared
    @State private var currentCategoryVM: CategoryViewModel? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Menu {
                        ForEach(categoryListVM.categoryVMs, id: \.id) { categoryVM in
                            Button(categoryVM.name) {
                                currentCategoryVM = categoryVM
                                problemListVM.showFilteredProblems(subString: searchText, categoryVM: currentCategoryVM)
                            }
                        }
                        Button("카테고리 전체") {
                            currentCategoryVM = nil
                            problemListVM.showFilteredProblems(subString: searchText, categoryVM: currentCategoryVM)
                        }
                    } label: {
                        CustomMenuLabel {
                            Text(currentCategoryVM?.name ?? "카테고리")
                                .font(.subheadline)
                        }
                    }
                    
                    Spacer()
                }
                
                CustomSearchBar(searchText: $searchText, placeholder: "제목으로 검색")
                    .onChange(of: searchText) { newValue in
                        problemListVM.showFilteredProblems(subString: searchText, categoryVM: currentCategoryVM)
                    }
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(problemListVM.problemVMs, id: \.id) { problemVM in
                            NavigationLink(destination: ProblemDetailScreen(problemVM: problemVM)) {
                                ProblemRow(title: problemVM.title, categoryString: problemVM.category?.name ?? "카테고리 없음", finished: problemVM.finished, assessment: problemVM.assessment, date: problemVM.date)
                                    .onLongPressGesture {
                                        deleteProblem(problemVM: problemVM)
                                    }
                            }
                            .tint(Color(UIColor.label))
                            
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("문제 목록")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProblemDetailScreen(problemVM: nil)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                problemListVM.showFilteredProblems(subString: searchText, categoryVM: currentCategoryVM)
            }
        }
    }
    
    private func deleteProblem(problemVM: ProblemViewModel) {
        AlertUtils.displayAlertView(title: "문제 제거", message: "정말로 문제르 삭제하시겠습니까?", okMessage: "삭제", okStyle: .destructive) {
            problemListVM.deleteProblem(problemVM: problemVM)
            problemListVM.showFilteredProblems(subString: searchText, categoryVM: currentCategoryVM)
        }
    }
}

struct ProblemListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListScreen().preferredColorScheme(.light)
    }
}
