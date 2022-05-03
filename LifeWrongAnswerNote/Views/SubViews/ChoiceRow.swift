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
    var color: Color {
        selected ? .green : .gray
    }
    
    init(selected: Bool, title: String) {
        self.selected = selected
        self.title = title
        self.titleInput = title
    }
    
    var body: some View {
        HStack(spacing: 13) {
            Image(systemName: selected ? "checkmark.circle.fill" : "circle")
            TextField("", text: $titleInput)
                .disabled(true)
            Spacer()
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 11)
        .foregroundColor(color)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(color))
    }
}

struct Choice_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceRow(selected: true, title: "선택 1")
    }
}
