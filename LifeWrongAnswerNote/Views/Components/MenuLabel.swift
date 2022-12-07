//
//  MenuView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct MenuLabel<Content: View>: View {
    let isClickable: Bool
    let content: () -> Content
    
    var body: some View {
        HStack {
            content()
            Spacer()
            Image(systemName: "chevron.down")
                .foregroundColor(Color(UIColor.systemGray3))
                .font(.system(size: 13, weight: .bold))
            
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 7)
        .frame(width: 120)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color(UIColor.systemGray3), lineWidth: 1)
        )
        .background(isClickable ? Color(UIColor.systemBackground) : Color(UIColor.systemGray5))
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuLabel(isClickable: true) {
            Text("카테고리")
                .font(.subheadline)
        }
    }
}
