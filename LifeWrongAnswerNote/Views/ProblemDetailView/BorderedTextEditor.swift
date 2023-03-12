//
//  BorderedTextEditor.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct BorderedTextEditor: View {
    @Binding var text: String
    let isEditable: Bool
    
    var body: some View {
        TextEditor(text: _text)
            .disabled(!isEditable)
            .foregroundColor(isEditable ? Color(.label) : Color(.systemGray))
            .scrollContentBackground(.hidden)
            .padding(.horizontal, 15)
            .padding(.vertical, 11)
            .background(
                Group {
                    if isEditable {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue)
                            .foregroundColor(.clear)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(Color(.systemGray5))
                    }
                }
            )
    }
}

struct BorderedTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        BorderedTextEditor(text: .constant("sadfasdfads"), isEditable: true)
    }
}
