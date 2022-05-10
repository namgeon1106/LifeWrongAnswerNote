//
//  CustomTextEditor.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/09.
//

import SwiftUI

struct CustomTextEditor: View {
    @Binding var text: String
    let editable: Bool
    
    var body: some View {
        ZStack {
            Group {
                if editable {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.blue)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(UIColor.systemGray5))
                }
            }
            
            TextEditor(text: _text)
                .foregroundColor(editable ? Color(UIColor.label) : Color(UIColor.systemGray))
                .disabled(!editable)
                .padding(.horizontal, 15)
                .padding(.vertical, 11)
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear() {
           UITextView.appearance().backgroundColor = nil
         }
    }
}

struct CustomTextEditor_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextEditor(text: .constant("sadfasdfads"), editable: true)
    }
}
