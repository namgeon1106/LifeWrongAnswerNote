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
                            
                        }
                    } label: {
                        CustomMenuLabel(clickable: true) {
                            Text("카테고리")
                                .font(.subheadline)
                        }
                    }
                    
                    Menu {
                        Button("진행상태 전체") {
                            
                        }
                    } label: {
                        CustomMenuLabel(clickable: true) {
                            Text("진행상태")
                                .font(.subheadline)
                        }
                    }
                    
                    Spacer()
                }
                
                CustomSearchBar(searchText: $problemListVM.searchText, placeholder: "제목으로 검색")
                
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(problemListVM.problemVMs, id: \.id) { problemVM in
                            NavigationLink(destination: Text("문제 읽기")) {
                                ProblemRow(title: problemVM.title, categoryString: problemVM.category?.name ?? "카테고리 없음", finished: problemVM.finished, assessment: problemVM.assessment, date: problemVM.date)
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
            .padding(.top, 23)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("문제 작성")) {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear {
                problemListVM.showFilteredProblems()
            }
        }
    }
}

struct ProblemListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListScreen()
    }
}
