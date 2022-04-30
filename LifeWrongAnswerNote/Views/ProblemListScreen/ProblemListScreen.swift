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
                
                Spacer()
            }
            .navigationTitle("고민들 목록")
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
