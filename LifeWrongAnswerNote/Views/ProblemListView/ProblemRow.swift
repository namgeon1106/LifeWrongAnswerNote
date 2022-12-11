//
//  ProblemRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct ProblemRow: View {
    let problemVM: ProblemViewModel
    
    var body: some View {
        NavigationLink(destination: ProblemDetailView(problemVM: problemVM)) {
            VStack(spacing: 5) {
                HStack(alignment: .center) {
                    Text(problemVM.title)
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                    problemVM.assessment.image
                        .font(.system(size: 25))
                }
                HStack {
                    Text("\(problemVM.categoryName) / \(problemVM.finishedInfo)")
                    Spacer()
                    Text(problemVM.dateString)
                        .foregroundColor(Color(.systemGray2))
                }
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 12)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .stroke()
                    .foregroundColor(Color(.systemGray5))
            )
            .foregroundColor(Color(.label))
        }
    }
}
