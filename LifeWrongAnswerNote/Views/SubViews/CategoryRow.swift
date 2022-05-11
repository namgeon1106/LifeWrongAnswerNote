//
//  CategoryRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/11.
//

import SwiftUI

struct CategoryRow: View {
    let title: String
    let count: Int
    var modifyAction: () -> Void
    var deleteAction: () -> Void
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(UIColor.systemGray5))
                .frame(height: 83)
            
            VStack(spacing: 10) {
                HStack {
                    Text(title)
                        .font(.title2)
                    Spacer()
                    Text("\(count)문제")
                }
                
                HStack(spacing: 13) {
                    Spacer()
                    Button(action: modifyAction) {
                        Image(systemName: "pencil.circle")
                            .foregroundColor(.blue)
                            .font(.title3)
                    }
                    
                    Button(action: deleteAction) {
                        Image(systemName: "trash.circle")
                            .foregroundColor(.red)
                            .font(.title3)
                    }
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 12)
        }
    }
}
struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow(title: "카테고리 1", count: 9, modifyAction: {}, deleteAction: {})
    }
}
