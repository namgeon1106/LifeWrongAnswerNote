//
//  ProblemListScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/09.
//

import SwiftUI

struct ProblemListScreen: View {
    @State private var searchText = ""
    
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
                
                CustomSearchBar(searchText: $searchText, placeholder: "제목으로 검색")
                
                ScrollView {
                    VStack(spacing: 20) {
                        NavigationLink(destination: Text("문제 읽기")) {
                            ProblemRow(title: "제목 1", categoryString: "카테고리 1", finished: true, assessment: .bad, date: Date())
                        }
                        .tint(Color(UIColor.label))
                        
                        NavigationLink(destination: Text("문제 읽기")) {
                            ProblemRow(title: "제목 2", categoryString: "카테고리 2", finished: false, assessment: .good, date: Date())
                        }
                        .tint(Color(UIColor.label))
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
        }
    }
}

struct ProblemListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListScreen()
    }
}
