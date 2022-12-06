//
//  CategoryRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import SwiftUI

struct CategoryRow: View {
    let categoryVM: CategoryViewModel
    let onModify: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(alignment: .center) {
                Text(categoryVM.name)
                    .font(.system(size: 22, weight: .bold))
                Spacer()
                Text("\(categoryVM.numberOfProblems)문제")
            }
            
            HStack(spacing: 13) {
                Spacer()
                Button(action: onModify) {
                    Image(systemName: "pencil.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.blue)
                }
                Button(action: onDelete) {
                    Image(systemName: "trash.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.red)
                }
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
