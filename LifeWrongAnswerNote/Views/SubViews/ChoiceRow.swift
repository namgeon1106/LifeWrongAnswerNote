//
//  Choice.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/01.
//

import SwiftUI

struct ChoiceRow: View {
    let selected: Bool
    let title: String
    @State private var titleInput: String
    let modifyAction: () -> Void
    let deleteAction: () -> Void
    
    var color: Color {
        selected ? .green : .gray
    }
    
    init(selected: Bool, title: String, modifyAction: @escaping () -> Void, deleteAction: @escaping () -> Void) {
        self.selected = selected
        self.title = title
        self.titleInput = title
        self.modifyAction = modifyAction
        self.deleteAction = deleteAction
    }
    
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: selected ? "checkmark.circle.fill" : "circle")
            TextField("", text: $titleInput)
                .disabled(true)
            Spacer()
            Button(action: modifyAction) {
                Image(systemName: "pencil.circle")
                    .foregroundColor(.blue)
            }.buttonStyle(BorderedButtonStyle())

            Button(action: deleteAction) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }.buttonStyle(BorderedButtonStyle())
        }
        .padding(.vertical, 5)
        .padding(.horizontal, 11)
        .foregroundColor(color)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(color))
    }
}

struct Choice_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceRow(selected: true, title: "선택 1", modifyAction: {}, deleteAction: {})
    }
}
