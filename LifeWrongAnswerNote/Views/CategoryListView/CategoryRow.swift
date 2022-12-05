//
//  CategoryRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import SwiftUI

struct CategoryRow: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                Text("카테고리 1")
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Text("9문제")
            }
            
            HStack(spacing: 13) {
                Spacer()
                Image(systemName: "pencil.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.blue)
                Image(systemName: "trash.circle")
                    .font(.system(size: 20))
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 12)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke()
                .foregroundColor(Color(.systemGray5))
        )
    }
}

struct CategoryRow_Previews: PreviewProvider {
    static var previews: some View {
        CategoryRow()
            .padding(.horizontal, 16)
    }
}
