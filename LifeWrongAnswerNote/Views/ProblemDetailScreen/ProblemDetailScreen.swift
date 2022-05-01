//
//  ProblemDetailScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ProblemDetailScreen: View {
    @State private var titleInput = ""
    @State private var situationInput = ""
    @State private var reasonInput = ""
    @State private var resultDetailInput = ""
    @State private var retrospectInput = ""
    
    @State private var choices = ["선택 1", "선택 2"]
    @State private var chosen: Int? = nil
    
    var body: some View {
        VStack {
            InputTemplate(title: "제목       ") {
                TextField("제목을 입력하세요", text: .constant(""))
            }
            .padding(.bottom, 9)
            
            InputTemplate(title: "카테고리") {
                HStack {
                    Menu {
                        Button("A", action: {})
                        Button("B", action: {})
                    } label: {
                        CustomMenuLabel(title: "카테고리")
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 9)
            
            InputTemplate(title: "평가       ") {
                HStack {
                    Menu {
                        Button("A", action: {})
                        Button("B", action: {})
                    } label: {
                        CustomMenuLabel(title: "평가")
                    }
                    Spacer()
                }
            }
            .padding(.bottom, 20)
            
            TabView {
                InputDetailTemplate(title: "1. 무슨 상황인가요?") {
                    CustomTextEditor(text: $situationInput)
                }
                
                InputDetailTemplate(title: "2. 가능한 선택과 내가 한 선택은?") {
                    VStack {
                        ForEach(0..<choices.count) { index in
                            Choice(selected: index == chosen, title: choices[index])
                                .onTapGesture {
                                    chosen = index
                                }
                        }
                        Button("+ 선택 추가") {
                            choices.append("새로운 선택")
                        }
                        .padding(.top, 10)
                    }
                }
                
                InputDetailTemplate(title: "3. 선택의 이유는?") {
                    CustomTextEditor(text: $reasonInput)
                }
                
                InputDetailTemplate(title: "4. 선택의 결과는?") {
                    CustomTextEditor(text: $reasonInput)
                }
                
                InputDetailTemplate(title: "5. 느낀점, 회고") {
                    CustomTextEditor(text: $retrospectInput)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 23)
        .navigationBarTitle("문제 읽기/수정")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProblemDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProblemDetailScreen().preferredColorScheme(.light)
        }
    }
}
