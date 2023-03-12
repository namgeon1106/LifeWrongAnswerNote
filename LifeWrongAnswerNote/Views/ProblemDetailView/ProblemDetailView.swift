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
    @State private var isEditing = true
    @Environment(\.presentationMode) private var presentationMode
    
    init(problemVM: ProblemViewModel?) {
        self._problemDetailVM = StateObject(wrappedValue: ProblemDetailViewModel(problemVM: problemVM))
        self._isEditing = State(initialValue: problemVM == nil)
    }
    
    var body: some View {
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
        .navigationTitle(isEditing ? "문제 작성" : "문제 읽기")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            categoryListVM.showAllCategories()
        }
        .modifier(problemDetailVM.addChoiceAlert(presented: $problemDetailVM.addChoiceAlertIsPresented))
        .modifier(problemDetailVM.modifyChoiceAlert(presented: $problemDetailVM.modifyChoiceAlertIsPresented))
        .modifier(problemDetailVM.deleteChoiceAlert(presented: $problemDetailVM.deleteChoiceAlertIsPresented))
        .alert("에러 발생", isPresented: $problemDetailVM.errorAlertIsPresented, actions: {
            Button("확인") {
                problemDetailVM.errorAlertIsPresented = false
            }
        }, message: {
            Text(problemDetailVM.errorMessage)
        })
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if isEditing {
                        problemDetailVM.saveProblem()
                    }
                    
                    isEditing.toggle()
                } label: {
                    Image(systemName: isEditing ? "checkmark" : "pencil")
                }
                
            }
        }
        .onDisappear {
            presentationMode.wrappedValue.dismiss()
            CoreDataManager.shared.viewContext.rollback()
        }
    }
    
    // MARK: - 요약 파트
    var summaryView: some View {
        VStack(spacing: 20) {
            SummaryInputTemplate(title: "제목") {
                TextField("제목", text: $problemDetailVM.title)
                    .disabled(!isEditing)
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
                    MenuLabel(isClickable: isEditing) {
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
                    MenuLabel(isClickable: isEditing) {
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
                    MenuLabel(isClickable: isEditing) {
                        problemDetailVM.assessment.image
                            .font(.system(size: 14))
                    }
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
        .foregroundColor(Color(.label))
        .disabled(!isEditing)
    }
    
    // MARK: - 세부 파트
    var titleView: some View {
        DetailInputTemplate(title: "1. 어떤 상황인지?") {
            BorderedTextEditor(text: $problemDetailVM.situation, isEditable: isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var choicesView: some View {
        DetailInputTemplate(title: "2. 가능한 선택과 내가 한 선택은?") {
            VStack(spacing: 10) {
                ForEach(problemDetailVM.enumeratedTempChoices, id: \.0) { index, tempChoice in
                    ChoiceRow(isSelected: tempChoice.isSelected, isEditable: isEditing, content: tempChoice.content, onModify: {
                        problemDetailVM.alertAndModifyChoice(at: index)
                    }, onDelete: {
                        problemDetailVM.alertAndDeleteChoice(at: index)
                    })
                    .onTapGesture {
                        problemDetailVM.tapChoice(at: index)
                    }
                }
                
                if isEditing {
                    Button("+ 선택 추가") {
                        problemDetailVM.addChoiceAlertIsPresented = true
                    }
                }
            }
        }
        .disabled(!isEditing)
        .padding(.horizontal, 16)
    }
    
    var reasonView: some View {
        DetailInputTemplate(title: "3. 선택의 이유는?") {
            BorderedTextEditor(text: $problemDetailVM.reason, isEditable: isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var resultView: some View {
        DetailInputTemplate(title: "4. 선택의 결과는?") {
            BorderedTextEditor(text: $problemDetailVM.result, isEditable: isEditing)
        }
        .padding(.horizontal, 16)
    }
    
    var lessonView: some View {
        DetailInputTemplate(title: "5. 느낀점, 교훈이 있는지?") {
            BorderedTextEditor(text: $problemDetailVM.lesson, isEditable: isEditing)
        }
        .padding(.horizontal, 16)
    }
}

struct ProblemDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProblemDetailView(problemVM: nil)
        }
    }
}
