//
//  SummaryInputTemplate.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/09.
//

import SwiftUI

struct SummaryInputTemplate<Content: View>: View {
    let title: String
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 43) {
                Text(title)
                    .frame(width: 59, alignment: .leading)
                content()
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            Divider()
        }
    }
}

struct SummaryInputTemplate_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 9) {
            SummaryInputTemplate(title: "제목") {
                TextField("제목을 입력하세요", text: .constant(""))
            }
            
            SummaryInputTemplate(title: "카테고리") {
                CustomMenuLabel(clickable: true) {
                    Text("카테고리")
                        .font(.subheadline)
                }
            }
            CustomTextEditor(text: .constant("sadf"), editable: false)
        }
        .padding(.horizontal, 16)
    }
}
