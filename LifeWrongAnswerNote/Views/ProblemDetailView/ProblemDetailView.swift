//
//  ProblemDetailView.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/07.
//

import SwiftUI

struct ProblemDetailView: View {
    @StateObject private var problemDetailVM: ProblemDetailViewModel
    @StateObject private var categoryListVM = CategoryListViewModel()
    
    init(problemVM: ProblemViewModel?) {
        self._problemDetailVM = StateObject(wrappedValue: ProblemDetailViewModel(problemVM: problemVM))
    }
    
    var body: some View {
        NavigationView {
            TabView {
                summaryView
                titleView
                choicesView
                reasonView
                resultView
                lessonView
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .navigationTitle("문제 수정")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                categoryListVM.showAllCategories()
            }
            .alert("선택지 추가", isPresented: $problemDetailVM.addChoiceAlertIsPresented, actions: {
                TextField("선택지 이름", text: $problemDetailVM.newChoiceContent)
                Button("취소", role: .cancel) {
                    problemDetailVM.addChoiceAlertIsPresented = false
                }
                Button("추가") {
                    problemDetailVM.addChoiceAlertIsPresented = false
                    problemDetailVM.addChoice()
                }
            }, message: {
                Text("새롭게 추가할 선택지의 내용을 입력하세요.")
            })
            .alert("선택지 수정", isPresented: $problemDetailVM.modifyChoiceAlertIsPresented, actions: {
                TextField("선택지 이름", text: $problemDetailVM.modifiedChoiceContent)
                Button("취소", role: .cancel) {
                    problemDetailVM.modifyChoiceAlertIsPresented = false
                }
                Button("추가") {
                    problemDetailVM.modifyChoiceAlertIsPresented = false
                    problemDetailVM.modifyChoice()
                }
            }, message: {
                Text("선택지의 새로운 내용을 입력하세요.")
            })
        }
    }
    
    var summaryView: some View {
        VStack(spacing: 20) {
            SummaryInputTemplate(title: "제목") {
                TextField("제목", text: $problemDetailVM.title)
                    .disabled(!problemDetailVM.isEditing)
            }
            SummaryInputTemplate(title: "카테고리") {
                Menu {
                    Button("카테고리 없음") {
                        problemDetailVM.categoryVM = nil
                    }
                    ForEach(categoryListVM.categoryVMs, id: \.id) { categoryVM in
                        Button(categoryVM.name) {
                            problemDetailVM.categoryVM = categoryVM
                        }
                    }
                } label: {
                    MenuLabel(isClickable: problemDetailVM.isEditing) {
                        Text(problemDetailVM.categoryVM?.name ?? "카테고리")
                            .font(.system(size: 14))
                    }
                }

            }
            SummaryInputTemplate(title: "진행상태") {
                Menu {
                    ForEach([true, false], id: \.self) { isFinished in
                        Button(isFinished ? "완료" : "진행 중") {
                            problemDetailVM.isFinished = isFinished
                        }
                    }
                } label: {
                    MenuLabel(isClickable: problemDetailVM.isEditing) {
                        Text(problemDetailVM.isFinished ? "완료" : "진행 중")
                            .font(.system(size: 14))
                    }
                }

            }
            SummaryInputTemplate(title: "평가") {
                Menu {
                    ForEach(Assessment.allCases, id: \.self) { assessment in
                        Button {
                            problemDetailVM.assessment = assessment
                        } label: {
                            HStack {
                                Text(assessment.description)
                                assessment.image
                            }
                        }

                    }
                } label: {
                    MenuLabel(isClickable: problemDetailVM.isEditing) {
                        problemDetailVM.assessment.image
                            .font(.system(size: 14))
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .foregroundColor(Color(.label))
    }
    
    var titleView: some View {
        DetailInputTemplate(title: "1. 어떤 상황인지?") {
            BorderedTextEditor(text: $problemDetailVM.title, isEditable: problemDetailVM.isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var choicesView: some View {
        DetailInputTemplate(title: "2. 가능한 선택과 내가 한 선택은?") {
            VStack(spacing: 10) {
                ForEach(problemDetailVM.enumeratedTempChoices, id: \.0) { index, tempChoice in
                    ChoiceRow(isSelected: tempChoice.isSelected, isEditable: problemDetailVM.isEditing, content: tempChoice.content, onModify: {
                        problemDetailVM.modifyingChoiceIndex = index
                        problemDetailVM.modifyChoiceAlertIsPresented = true
                    }, onDelete: {})
                }
                
                if problemDetailVM.isEditing {
                    Button("+ 선택 추가") {
                        problemDetailVM.addChoiceAlertIsPresented = true
                    }
                }
            }
        }
        .padding(.horizontal, 16)
    }
    
    var reasonView: some View {
        DetailInputTemplate(title: "3. 선택의 이유는?") {
            BorderedTextEditor(text: $problemDetailVM.reason, isEditable: problemDetailVM.isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var resultView: some View {
        DetailInputTemplate(title: "4. 선택의 결과는?") {
            BorderedTextEditor(text: $problemDetailVM.result, isEditable: problemDetailVM.isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var lessonView: some View {
        DetailInputTemplate(title: "5. 느낀점, 교훈이 있는지?") {
            BorderedTextEditor(text: $problemDetailVM.lesson, isEditable: problemDetailVM.isEditing)
        }
        .padding(.horizontal, 16)
    }
}

struct ProblemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProblemDetailView(problemVM: nil)
    }
}
