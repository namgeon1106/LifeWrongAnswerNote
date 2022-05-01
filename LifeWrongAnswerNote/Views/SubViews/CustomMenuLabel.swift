//
//  CustomMenuLabel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct CustomMenuLabel: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
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
    }
}

struct CustomMenuLabel_Previews: PreviewProvider {
    static var previews: some View {
        CustomMenuLabel(title: "카테고리")
    }
}
