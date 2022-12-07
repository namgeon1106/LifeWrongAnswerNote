//
//  ChoiceRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct ChoiceRow: View {
    let isSelected: Bool
    let isEditable: Bool
    let content: String
    let onModify: () -> Void
    let onDelete: () -> Void
    
    var color: Color {
        isSelected ? .green : .gray
    }
    
    var checkImage: some View {
        Group {
            if isEditable {
                Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
            } else {
                Group {
                    if isSelected {
                        Image(systemName: "checkmark")
                    } else {
                        Text("")
                            
                    }
                }
            }
        }
        .font(.system(size: 17))
        .frame(width: 20)
    }
    
    var body: some View {
        HStack(spacing: 13) {
            checkImage
            
            Text(content)
                .font(.system(size: 18))
            
            Spacer()
            
            if isEditable {
                Button(action: onModify) {
                    Image(systemName: "pencil.circle")
                        .foregroundColor(.blue)
                        .font(.system(size: 20))
                }
                
                Button(action: onDelete) {
                    Image(systemName: "trash.circle")
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                }
            }
        }
        .foregroundColor(color)
        .padding(.vertical, 12)
        .padding(.horizontal, 9)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(color)
        )
    }
}

struct ChoiceRow_Previews: PreviewProvider {
    static var previews: some View {
        ChoiceRow(isSelected: true, isEditable: false, content: "선택 1", onModify: {}, onDelete: {})
    }
}
