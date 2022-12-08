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
                titleView
                choicesView
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationTitle("문제 수정")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    var summaryView: some View {
        VStack(spacing: 20) {
            SummaryInputTemplate(title: "제목") {
                TextField("제목", text: $title)
                    .disabled(!isEditing)
            }
            SummaryInputTemplate(title: "카테고리") {
                MenuLabel(isClickable: isEditing) {
                    Text("카테고리")
                        .font(.system(size: 14))
                }
            }
            SummaryInputTemplate(title: "진행상태") {
                MenuLabel(isClickable: isEditing) {
                    Text("진행 중")
                        .font(.system(size: 14))
                }
            }
            SummaryInputTemplate(title: "평가") {
                MenuLabel(isClickable: isEditing) {
                    Text("평가")
                        .font(.system(size: 14))
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
    
    var titleView: some View {
        DetailInputTemplate(title: "1. 어떤 상황이었나요?") {
            BorderedTextEditor(text: $title, isEditable: isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var choicesView: some View {
        DetailInputTemplate(title: "2. 가능한 선택과 내가 한 선택은?") {
            VStack(spacing: 10) {
                ForEach(0..<3) { _ in
                    ChoiceRow(isSelected: false, isEditable: isEditing, content: "선택 1", onModify: {}, onDelete: {})
                }
                
                if isEditing {
                    Button("+ 선택 추가") {
                        
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ProblemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemDetailView()
    }
}
