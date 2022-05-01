//
//  ProblemDetailScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ProblemDetailScreen: View {
    @State private var titleInput = ""
    
    var body: some View {
        VStack {
            InputTemplate(title: "제목       ") {
                TextField("제목을 입력하세요", text: .constant(""))
            }
            .padding(.bottom, 9)
            
            InputTemplate(title: "카테고리") {
                HStack {
                    Menu {
                        Button("A", action: {})
                        Button("B", action: {})
                    } label: {
                        CustomMenuLabel(title: "카테고리")
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 20)
            
            TabView {
                Text("1")
                Text("2")
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 23)
        .navigationBarTitle("문제 읽기/수정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProblemDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProblemDetailScreen().preferredColorScheme(.light)
        }
    }
}
