//
//  CustomSearchBar.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/05.
//

import SwiftUI

struct CustomSearchBar: View {
    @Binding var searchText: String
    let placeholder: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField(placeholder, text: $searchText)
            Spacer(minLength: 0)
            if !searchText.isEmpty {
                Button {
                    searchText = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(Color(.systemGray2))
                        .frame(width: 8, height: 8)
                        .padding(.trailing, 4)
                }
                
            }
        }
        .padding(.vertical, 7)
        .padding(.horizontal, 4)
        .background(RoundedRectangle(cornerRadius: 10).foregroundColor(Color(UIColor.systemGray6)))
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomSearchBar(searchText: .constant(""), placeholder: "제목으로 검색")
            .padding(.horizontal, 16)
    }
}
