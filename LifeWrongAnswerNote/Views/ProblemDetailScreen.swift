//
//  ProblemDetailScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/10.
//

import SwiftUI

struct ProblemDetailScreen: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject private var problemDetailVM: ProblemDetailViewModel
    
    init(problemVM: ProblemViewModel?) {
        _problemDetailVM = StateObject<ProblemDetailViewModel>(wrappedValue: ProblemDetailViewModel(problemVM: problemVM))
    }
    
    var body: some View {
        TabView {
            VStack {
                SummaryInputTemplate(title: "제목") {
                    TextField("제목을 입력하세요", text: $problemDetailVM.titleInput)
                        .disabled(!problemDetailVM.editable)
                }
                
                SummaryInputTemplate(title: "카테고리") {
                    Menu {
                        Button("카테고리 없음") {
                            
                        }
                    } label: {
                        CustomMenuLabel(clickable: problemDetailVM.editable) {
                            Text("카테고리").font(.subheadline)
                        }
                    }
                    .disabled(!problemDetailVM.editable)
                }
                
                SummaryInputTemplate(title: "진행상태") {
                    Menu {
                        Button("진행 중") {
                            
                        }
                        
                        Button("완료") {
                            
                        }
                    } label: {
                        CustomMenuLabel(clickable: problemDetailVM.editable) {
                            Text("진행상태").font(.subheadline)
                        }
                    }
                    .disabled(!problemDetailVM.editable)
                }
                
                SummaryInputTemplate(title: "평가") {
                    Menu {
                        ForEach(Assessment.allValues, id: \.self) { assessment in
                            Button {
                                problemDetailVM.assessmentInput = assessment
                            } label: {
                                HStack {
                                    Text(assessment.description)
                                    assessment.image
                                }
                            }

                        }
                    } label: {
                        CustomMenuLabel(clickable: problemDetailVM.editable) {
                            problemDetailVM.assessmentInput.image
                            .font(.subheadline)
                        }
                    }
                    .disabled(!problemDetailVM.editable)
                }
                
                Spacer()
            }
            
            DetailInputTemplate(title: "1. 무슨 상황인가요?") {
                CustomTextEditor(text: $problemDetailVM.situationInput, editable: problemDetailVM.editable)
            }
            
            DetailInputTemplate(title: "2. 가능한 선택들과 내가 한 선택은?") {
                VStack(spacing: 10) {
                    ChoiceRow(selected: false, editable: problemDetailVM.editable, title: "선택 1", modifyAction: {}, deleteAction: {})
                    
                    ChoiceRow(selected: true, editable: problemDetailVM.editable, title: "선택 2", modifyAction: {}, deleteAction: {})
                    
                    if problemDetailVM.editable {
                        Button("+ 선택 추가") {
                            
                        }
                        .font(.title3)
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
            }
            
            DetailInputTemplate(title: "3. 선택의 이유는?") {
                CustomTextEditor(text: $problemDetailVM.reasonInput, editable: problemDetailVM.editable)
            }
            
            DetailInputTemplate(title: "4. 선택의 결과는?") {
                CustomTextEditor(text: $problemDetailVM.resultInput, editable: problemDetailVM.editable)
            }
            
            DetailInputTemplate(title: "5. 느낀 점, 회고") {
                CustomTextEditor(text: $problemDetailVM.retrospectionInput, editable: problemDetailVM.editable)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 23)
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        .navigationBarTitle("문제 \(problemDetailVM.editable ? "작성" : "읽기")")
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
                problemDetailVM.editable ?
                Button {
                    problemDetailVM.saveProblem()
                } label: {
                    Image(systemName: "checkmark")
                }
                :
                Button {
                    problemDetailVM.editable.toggle()
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
            ProblemDetailScreen(problemVM: nil)
        }
    }
}
