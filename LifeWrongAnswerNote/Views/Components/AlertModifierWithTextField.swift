//
//  AlertWithTextField.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/09.
//

import Foundation
import SwiftUI

struct AlertModifierWithTextField: ViewModifier {
    @Binding var presented: Bool
    @State private var input = ""
    let title: String
    let message: String
    let okMessage: String
    let action: (String) -> Void
    
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $presented, actions: {
                TextField("입력", text: $input)
                Button("취소", role: .cancel) {
                    presented = false
                    input = ""
                }
                Button(okMessage) {
                    presented = false
                    action(input)
                    input = ""
                }
            }, message: {
                Text(message)
            })
    }
}
