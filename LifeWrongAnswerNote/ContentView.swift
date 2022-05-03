//
//  ContentView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProblemListScreen()
                .tabItem {
                    VStack {
                        Image(systemName: "text.book.closed")
                        Text("문제 목록")
                    }
                }
            
            CategoryListScreen()
                .tabItem {
                    VStack {
                        Image(systemName: "list.triangle")
                        Text("카테고리 관리")
                    }
                }
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .systemGray6
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
