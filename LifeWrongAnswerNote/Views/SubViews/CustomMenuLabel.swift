//
//  CustomMenuLabel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/09.
//

import SwiftUI

struct CustomMenuLabel<Content: View>: View {
    let clickable: Bool
    let content: () -> Content
    
    var body: some View {
        HStack {
            content()
            Spacer()
            Image(systemName: "chevron.down")
                .resizable()
                .scaledToFit()
                .frame(width: 10, height: 10)
                .foregroundColor(Color(UIColor.systemGray3))
            
        }
        .padding(.horizontal, 13)
        .frame(width: 120, height: 32)
        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color(UIColor.systemGray3), lineWidth: 1))
        .background(clickable ? Color(UIColor.systemBackground) : Color(UIColor.systemGray5))
    }
}

struct CustomMenuLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenuLabel(clickable: true) {
            Text("카테고리")
                .font(.subheadline)
        }
    }
}
