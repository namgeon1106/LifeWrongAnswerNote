//
//  ChoiceRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/10.
//

import SwiftUI

struct ChoiceRow: View {
    let selected: Bool
    let editable: Bool
    let title: String
    let modifyAction: () -> Void
    let deleteAction: () -> Void
    
    var color: Color {
        selected ? .green : .gray
    }
    
    var body: some View {
        HStack(spacing: 13) {
            Group {
                if editable {
                    Image(systemName: selected ? "checkmark.circle.fill" : "circle")
                } else {
                    Image(systemName: selected ? "checkmark" : "")
                       .frame(width: 20)
                }
            }
            
            Text(title)
                .padding(.vertical, 1)
            Spacer()
            
            if editable {
                Button(action: modifyAction) {
                    Image(systemName: "pencil.circle")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                .padding(.trailing, 5)

                Button(action: deleteAction) {
                    Image(systemName: "trash")
                        .font(.title3)
                        .foregroundColor(.red)
                        
                }
                .padding(.trailing, 5)
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 9)
        .foregroundColor(color)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(color))
    }
}

struct Choice_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceRow(selected: true, editable: false, title: "선택 1", modifyAction: {}, deleteAction: {})
    }
}
