//
//  AlertModifier.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/09.
//

import Foundation
import SwiftUI

struct AlertModifier: ViewModifier {
    @Binding var presented: Bool
    let title: String
    let message: String
    let okMessage: String
    let okStyle: ButtonRole
    let action: () -> Void
    
    func body(content: Content) -> some View {
        content
            .alert(title, isPresented: $presented, actions: {
                Button("취소", role: .cancel) {
                    presented = false
                }
                Button(okMessage, role: okStyle) {
                    presented = false
                    action()
                }
            }, message: {
                Text(message)
            })
    }
}
