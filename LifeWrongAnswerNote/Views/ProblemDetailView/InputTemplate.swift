//
//  InputTemplate.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct InputTemplate<Content: View>: View {
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

struct InputTemplate_Previews: PreviewProvider {
    static var previews: some View {
        InputTemplate(title: "제목") {
            TextField("제목을 입력하세요", text: .constant(""))
        }
    }
}
