//
//  InputTemplate.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct InputTemplate<Content: View>: View {
    let title: String
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 43) {
                Text(title)
                content()
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            Divider()
        }
    }
}

struct InputTemplate_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 9) {
            InputTemplate(title: "제목       ") {
                TextField("제목을 입력하세요", text: .constant(""))
            }
            
            InputTemplate(title: "카테고리") {
                HStack {
                    CustomMenuLabel(title: "카테고리")
                    Spacer()
                }
            }
        }
    }
}
