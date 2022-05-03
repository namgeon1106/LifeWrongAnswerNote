//
//  InputDetailTemplate.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/01.
//

import SwiftUI

struct InputDetailTemplate<Content: View>: View {
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

struct InputDetailTemplate_Previews: PreviewProvider {
    static var previews: some View {
        InputDetailTemplate(title: "1. 어떤 상황인가요?") {
            TextEditor(text: .constant(""))
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(.blue))
        }
    }
}
