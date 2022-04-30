//
//  ProblemRowView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ProblemRow: View {
    let title: String
    let categoryString: String
    let assessment: Assessment
    let date: Date
    var formatter: DateFormatter {
        let rawFormatter = DateFormatter()
        rawFormatter.dateFormat = "yyyy.MM.dd"
        
        return rawFormatter
    }
    
    var body: some View {
        VStack(spacing: 5) {
            HStack {
                Text(title)
                    .font(.title2)
                    .fontWeight(.bold)
                Spacer()
                assessment.image
                    .font(.title2)
            }
            
            HStack {
                Text(categoryString)
                    .font(.subheadline)
                Spacer()
                Text(formatter.string(from: Date()))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 12)
        .overlay(RoundedRectangle(cornerRadius: 8)
            .stroke(Color(UIColor.systemGray3), lineWidth: 1))
    }
}

struct ProblemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemRow(title: "제목 1", categoryString: "카테고리 1", assessment: .bad, date: Date())
    }
}
