//
//  ProblemRow.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct ProblemRow: View {
    var body: some View {
        NavigationLink(destination: Text("Hello")) {
            VStack(spacing: 5) {
                HStack(alignment: .center) {
                    Text("제목 1")
                        .font(.system(size: 22, weight: .bold))
                    Spacer()
                    Image(systemName: "checkmark.circle")
                        .foregroundColor(.green)
                        .font(.system(size: 25))
                }
                HStack {
                    Text("카테고리1 / 진행 중")
                    Spacer()
                    Text("2022.12.07")
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

struct ProblemRow_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProblemRow()
        }
    }
}
