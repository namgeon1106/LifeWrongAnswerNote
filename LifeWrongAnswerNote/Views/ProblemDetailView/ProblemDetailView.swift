//
//  ProblemDetailView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct ProblemDetailView: View {
    @State private var title = ""
    @State private var situation = ""
    @State private var reason = ""
    @State private var result = ""
    @State private var lesson = ""
    @State private var isEditing = true
    
    var body: some View {
        NavigationView {
            TabView {
                summaryView
            }
            .tabViewStyle(PageTabViewStyle())
            .navigationTitle("문제 수정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var summaryView: some View {
        VStack(spacing: 20) {
            InputTemplate(title: "제목") {
                TextField("제목", text: $title)
                    .disabled(!isEditing)
            }
            InputTemplate(title: "카테고리") {
                MenuLabel(isClickable: isEditing) {
                    Text("카테고리")
                        .font(.system(size: 14))
                }
            }
            InputTemplate(title: "진행상태") {
                MenuLabel(isClickable: isEditing) {
                    Text("진행 중")
                        .font(.system(size: 14))
                }
            }
            InputTemplate(title: "평가") {
                MenuLabel(isClickable: isEditing) {
                    Text("평가")
                        .font(.system(size: 14))
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

struct ProblemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemDetailView()
    }
}
