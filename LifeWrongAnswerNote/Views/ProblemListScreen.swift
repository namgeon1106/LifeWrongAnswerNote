//
//  ProblemListScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/09.
//

import SwiftUI

struct ProblemListScreen: View {
    @StateObject var problemListVM = ProblemListViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Menu {
                        Button("카테고리 전체") {
                            problemListVM.categoryInput = nil
                        }
                        
                        ForEach(problemListVM.categoryListVM.categoryVMs, id: \.id) { categoryVM in
                            Button(categoryVM.name) {
                                problemListVM.categoryInput = categoryVM
                            }
                        }
                    } label: {
                        CustomMenuLabel(clickable: true) {
                            Text(problemListVM.categoryInput?.name ?? "카테고리")
                                .font(.subheadline)
                        }
                    }
                    .onChange(of: problemListVM.categoryInput) { newValue in
                        problemListVM.showFilteredProblems()
                    }
                    
                    Menu {
                        Button("진행상태 전체") {
                            problemListVM.finishedInput = nil
                        }
                        
                        ForEach([true, false], id: \.self) { value in
                            Button(value ? "완료" :"진행 중") {
                                problemListVM.finishedInput = value
                            }
                        }
                    } label: {
                        CustomMenuLabel(clickable: true) {
                            Text(problemListVM.finishedInput != nil ?
                                 problemListVM.finishedInput! ? "완료" : "진행 중"
                                 : "진행상태")
                                .font(.subheadline)
                        }
                    }
                    .onChange(of: problemListVM.finishedInput) { newValue in
                        problemListVM.showFilteredProblems()
                    }
                    Spacer()
                }
                
                CustomSearchBar(searchText: $problemListVM.searchText, placeholder: "제목으로 검색")
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(problemListVM.problemVMs, id: \.id) { problemVM in
                            HStack {
                                NavigationLink(destination: ProblemDetailScreen(problemVM: problemVM)) {
                                    ProblemRow(title: problemVM.title, categoryString: problemVM.category?.name ?? "카테고리 없음", finished: problemVM.finished, assessment: problemVM.assessment, date: problemVM.date)
                                }
                                .tint(Color(UIColor.label))
                                if problemListVM.deletable {
                                    Button {
                                        problemListVM.deleteProblem(problemVM: problemVM)
                                    } label: {
                                        Image(systemName: "trash")
                                            .foregroundColor(.white)
                                    }
                                    .frame(maxWidth: 50, maxHeight: .infinity)
                                    .background(.red)
                                }
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .navigationTitle("문제 목록")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal, 16)
            .padding(.top, 23)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        problemListVM.deletable.toggle()
                    } label: {
                        Image(systemName: "trash")
                    }

                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: ProblemDetailScreen(problemVM: nil)) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                problemListVM.showFilteredProblems()
                problemListVM.categoryListVM.showAllCategories()
            }
        }
    }
}

struct ProblemListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListScreen()
    }
}
