//
//  BorderedTextEditor.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct BorderedTextEditor: View {
    @Binding var text: String
    let editable: Bool
    
    var body: some View {
        TextEditor(text: _text)
            .disabled(!editable)
            .foregroundColor(editable ? Color(.label) : Color(.systemGray))
            .padding(.horizontal, 15)
            .padding(.vertical, 11)
            .colorMultiply(editable ? Color(.systemBackground) : Color(.systemGray5))
            .background(
                Group {
                    if editable {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.blue)
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
        BorderedTextEditor(text: .constant("sadfasdfads"), editable: true)
    }
}
