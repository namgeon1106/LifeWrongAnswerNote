//
//  ProblemDetailScreen.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/04/30.
//

import SwiftUI

struct ProblemDetailScreen: View {
    @ObservedObject var problemDetailVM = ProblemDetailViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var problemListVM = ProblemListViewModel.shared
    @State private var choiceActionSheetPresented = false
    @State private var modifyingChoiceVM: ChoiceViewModel? = nil
    
    let problemVM: ProblemViewModel?
    
    init(problemVM: ProblemViewModel?) {
        self.problemVM = problemVM
        
        if let problemVM = problemVM {
            problemDetailVM.title = problemVM.title
            problemDetailVM.category = problemVM.category
            problemDetailVM.situation = problemVM.situation
            problemDetailVM.chosen = problemVM.chosen
            problemDetailVM.reason = problemVM.reason
            problemDetailVM.result = problemVM.result
            problemDetailVM.retrospection = problemVM.retrospection
        }
    }
    
    var body: some View {
        VStack {
            InputTemplate(title: "제목       ") {
                TextField("제목을 입력하세요", text: $problemDetailVM.title)
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
                    CustomTextEditor(text: $problemDetailVM.situation)
                }
                
                InputDetailTemplate(title: "2. 가능한 선택과 내가 한 선택은?") {
                    VStack {
                        ForEach(problemDetailVM.choiceVMs, id: \.id) { choiceVM in
                            ChoiceRow(selected: choiceVM.id == problemDetailVM.chosen?.objectID, title: choiceVM.content)
                                .onTapGesture {
                                    problemDetailVM.choose(choiceVM: choiceVM)
                                    problemDetailVM.getChoicesInProblem(problemVM: problemVM)
                                }
                                .onLongPressGesture {
                                    modifyingChoiceVM = choiceVM
                                    choiceActionSheetPresented = true
                                }
                        }
                        
                        Button("+ 선택 추가") {
                            AlertUtils.displayAlertViewWithTextField(title: "새 선택지 추가", message: "새로 추가할 선택의 이름을 입력하세요.", placeholder: "선택 이름 입력", okMessage: "추가", okStyle: .default) { 
                                problemDetailVM.addChoice(content: AlertUtils.alertTextInput, problemVM: problemVM)
                                problemDetailVM.getChoicesInProblem(problemVM: problemVM)
                            }
                        }
                        .padding(.top, 10)
                    }
                }
                
                InputDetailTemplate(title: "3. 선택의 이유는?") {
                    CustomTextEditor(text: $problemDetailVM.reason)
                }
                
                InputDetailTemplate(title: "4. 선택의 결과는?") {
                    CustomTextEditor(text: $problemDetailVM.result)
                }
                
                InputDetailTemplate(title: "5. 느낀점, 회고") {
                    CustomTextEditor(text: $problemDetailVM.retrospection)
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    CoreDataManager.shared.viewContext.rollback()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "arrow.backward")
                }

            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if let problemVM = problemVM {
                        problemDetailVM.modifyProblem(problemVM: problemVM)
                    } else {
                        problemDetailVM.addProblem()
                    }
                    presentationMode.wrappedValue.dismiss()
                    problemListVM.showAllProblems()
                } label: {
                    Image(systemName: "checkmark")
                }

            }
        }
        .onAppear {
            problemDetailVM.getChoicesInProblem(problemVM: problemVM)
        }
        .confirmationDialog("", isPresented: $choiceActionSheetPresented) {
            Button("변경") {
                modifyChoice(choiceVM: modifyingChoiceVM!)
            }
            Button(role: .destructive) {
                deleteChoice(choiceVM: modifyingChoiceVM!)
            } label: {
                Text("삭제")
            }

        }
    }
    
    func modifyChoice(choiceVM: ChoiceViewModel) {
        AlertUtils.displayAlertViewWithTextField(title: "선택지 내용 변경", message: "새로운 내용을 입력하세요.", placeholder: "선택 이름 입력", okMessage: "변경", okStyle: .default) {
            problemDetailVM.modifyChoice(content: AlertUtils.alertTextInput, choiceVM: choiceVM, problemVM: problemVM)
            problemDetailVM.getChoicesInProblem(problemVM: problemVM)
        }
    }
    
    func deleteChoice(choiceVM: ChoiceViewModel) {
        AlertUtils.displayAlertView(title: "선택지 삭제", message: "선택지를 삭제하시겠습니까?", okMessage: "삭제", okStyle: .destructive) {
            problemDetailVM.deleteChoice(choiceVM: choiceVM)
            problemDetailVM.getChoicesInProblem(problemVM: problemVM)
        }
    }
}

struct ProblemDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProblemDetailScreen(problemVM: nil).preferredColorScheme(.light)
        }
    }
}
