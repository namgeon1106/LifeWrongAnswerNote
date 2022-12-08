//
//  DetailInputTemplate.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/08.
//

import SwiftUI

struct DetailInputTemplate<Content: View>: View {
    let title: String
    var content: () -> Content
    
    var body: some View {
        VStack {
            HStack {
                Text(title)
                    .padding(.leading, 11)
                Spacer()
            }
            .padding(.bottom, 4)
            Divider()
            content()
                .padding(.top, 16)
                .padding(.horizontal, 11)
            Spacer()
        }
        .padding(.bottom, 70)
    }
}

struct DetailInputTemplate_Previews: PreviewProvider {
    static var previews: some View {
        DetailInputTemplate(title: "1. 어떤 상황인가요?") {
            BorderedTextEditor(text: .constant(""), isEditable: false)
        }
    }
}
