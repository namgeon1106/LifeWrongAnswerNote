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
                    Menu {
                        Button("전체") {
                            problemListVM.categoryVM = nil
                        }
                        
                        ForEach(categoryListVM.categoryVMs, id: \.id) { categoryVM in
                            Button(categoryVM.name) {
                                problemListVM.categoryVM = categoryVM
                            }
                        }
                    } label: {
                        MenuLabel(isClickable: true) {
                            Text(problemListVM.categoryVM?.name ?? "카테고리")
                                .font(.system(size: 14))
                        }
                    }

                    Menu {
                        Button("전체") {
                            problemListVM.isFinished = nil
                        }
                        
                        ForEach([false, true], id: \.self) { isFinished in
                            Button(isFinished ? "완료" : "진행 중") {
                                problemListVM.isFinished = isFinished
                            }
                        }
                    } label: {
                        MenuLabel(isClickable: true) {
                            Text(problemListVM.isFinishedText)
                                .font(.system(size: 14))
                        }
                    }

                    Spacer()
                }
                .padding(.horizontal, 16)
                .tint(Color(.label))
                
                CustomSearchBar(searchText: $problemListVM.searchText, placeholder: "제목으로 검색")
                    .padding(.horizontal, 16)
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(problemListVM.enumeratedProblemVMs, id: \.0) { index, problemVM in
                            HStack {
                                ProblemRow(problemVM: problemVM)
                                
                                if problemListVM.deleteButtonIsVisible {
                                    Button {
                                        problemListVM.alertAndDeleteProblem(at: index)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                            .tint(.white)
                                            .frame(maxWidth: 40, maxHeight: .infinity)
                                            .background(.red)
                                    }
                                }
                            }
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
            .modifier(problemListVM.deleteProblemAlert(presented: $problemListVM.deleteProblemAlertIsPresented))
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ProblemDetailView(problemVM: nil)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        problemListVM.deleteButtonIsVisible.toggle()
                    } label: {
                        Image(systemName: problemListVM.deleteButtonIsVisible ? "arrow.backward" : "trash")
                    }
                    .tint(.red)
                }
            }
            .alert("에러 발생", isPresented: $problemListVM.errorAlertIsPresented, actions: {
                Button("확인") {
                    problemListVM.errorAlertIsPresented = false
                }
            }, message: {
                Text(problemListVM.errorMessage)
            })
        }
    }
}

struct ProblemListView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListView()
    }
}
