//
//  ProblemListScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ProblemListScreen: View {
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                HStack(spacing: 16) {
                    Menu {
                        Button("sss", action: {})
                        Button("ddd", action: {})
                    } label: {
                        CustomMenuLabel(title: "카테고리")
                    }
                    
                    Menu {
                        Button("sss", action: {})
                        Button("ddd", action: {})
                    } label: {
                        CustomMenuLabel(title: "진행상태")
                    }
                    
                    Spacer()
                }
                
                CustomSearchBar(searchText: $searchText, placeholder: "제목으로 검색")
                
                ScrollView {
                    VStack(spacing: 20) {
                        NavigationLink(destination: ProblemDetailScreen()) {
                            ProblemRow(title: "제목 1", categoryString: "카테고리 1", assessment: .good, date: Date())
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ProblemDetailScreen()) {
                            ProblemRow(title: "제목 2", categoryString: "카테고리 1", assessment: .bad, date: Date())
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ProblemDetailScreen()) {
                            ProblemRow(title: "제목 3", categoryString: "카테고리 2", assessment: .soso, date: Date())
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        NavigationLink(destination: ProblemDetailScreen()) {
                            ProblemRow(title: "제목 4", categoryString: "카테고리 2", assessment: .notSure, date: Date())
                        }
                        .buttonStyle(PlainButtonStyle())
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
                    NavigationLink(destination: Text("sss")) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ProblemListScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProblemListScreen().preferredColorScheme(.light)
    }
}
