//
//  ProblemDetailScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/10.
//

import SwiftUI

struct ProblemDetailScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State private var titleInput = ""
    
    @State private var situationInput = ""
    @State private var reasonInput = ""
    @State private var resultInput = ""
    @State private var retrospectionInput = ""
    @State var editable: Bool
    
    var body: some View {
        TabView {
            VStack {
                SummaryInputTemplate(title: "제목") {
                    TextField("제목을 입력하세요", text: $titleInput)
                        .disabled(!editable)
                }
                
                SummaryInputTemplate(title: "카테고리") {
                    Menu {
                        Button("카테고리 없음") {
                            
                        }
                    } label: {
                        CustomMenuLabel(clickable: editable) {
                            Text("카테고리").font(.subheadline)
                        }
                    }
                    .disabled(!editable)
                }
                
                SummaryInputTemplate(title: "진행상태") {
                    Menu {
                        Button("진행 중") {
                            
                        }
                        
                        Button("완료") {
                            
                        }
                    } label: {
                        CustomMenuLabel(clickable: editable) {
                            Text("진행상태").font(.subheadline)
                        }
                    }
                    .disabled(!editable)
                }
                
                SummaryInputTemplate(title: "평가") {
                    Menu {
                        ForEach(Assessment.allValues, id: \.self) { assessment in
                            Button {
                                
                            } label: {
                                HStack {
                                    Text(assessment.description)
                                    assessment.image
                                }
                            }

                        }
                    } label: {
                        CustomMenuLabel(clickable: editable) {
                            Text("평가").font(.subheadline)
                        }
                    }
                    .disabled(!editable)
                }
                
                Spacer()
            }
            
            DetailInputTemplate(title: "1. 무슨 상황인가요?") {
                CustomTextEditor(text: $situationInput, editable: editable)
            }
            
            DetailInputTemplate(title: "2. 가능한 선택들과 내가 한 선택은?") {
                VStack(spacing: 10) {
                    ChoiceRow(selected: false, editable: editable, title: "선택 1", modifyAction: {}, deleteAction: {})
                    
                    ChoiceRow(selected: true, editable: editable, title: "선택 2", modifyAction: {}, deleteAction: {})
                    
                    if editable {
                        Button("+ 선택 추가") {
                            
                        }
                        .font(.title3)
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
            }
            
            DetailInputTemplate(title: "3. 선택의 이유는?") {
                CustomTextEditor(text: $reasonInput, editable: editable)
            }
            
            DetailInputTemplate(title: "4. 선택의 결과는?") {
                CustomTextEditor(text: $resultInput, editable: editable)
            }
            
            DetailInputTemplate(title: "5. 느낀 점, 회고") {
                CustomTextEditor(text: $retrospectionInput, editable: editable)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 23)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarTitle("문제 \(editable ? "작성" : "읽기")")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                }

            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                editable ?
                Button {
                    editable.toggle()
                } label: {
                    Image(systemName: "checkmark")
                }
                :
                Button {
                    editable.toggle()
                } label: {
                    Image(systemName: "pencil.circle")
                }
            }
        }
    }
}

struct ProblemDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProblemDetailScreen(editable: false)
        }
    }
}
