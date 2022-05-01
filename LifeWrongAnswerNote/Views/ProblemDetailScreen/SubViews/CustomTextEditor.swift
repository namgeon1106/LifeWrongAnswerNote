//
//  CustomTextEditor.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/01.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    
    var body: some View {
        TextEditor(text: _text)
            .padding(.horizontal, 15)
            .padding(.vertical, 11)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(.blue))
    }
}

struct CustomTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextEditor(text: .constant(""))
    }
}
