//
//  ContentView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/03.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ProblemListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.clipboard")
                        Text("문제 목록")
                    }
                }
            CategoryListView()
                .tabItem {
                    VStack {
                        Image(systemName: "list.bullet")
                        Text("카테고리 목록")
                    }
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
