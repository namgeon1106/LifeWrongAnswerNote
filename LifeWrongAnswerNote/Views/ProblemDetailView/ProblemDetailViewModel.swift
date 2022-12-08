//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/08.
//

import Foundation
import SwiftUI

class ProblemDetailViewModel: ObservableObject {
    private let problem: Problem
    @Published var errorAlertIsPresented = false
    @Published var errorMessage = "" {
        didSet {
            errorAlertIsPresented = true
        }
    }
    
    init(problemVM: ProblemViewModel?) {
        problem = problemVM?.problem ?? Problem(context: CoreDataManager.shared.viewContext)
        
        if problemVM == nil {
            problem.createdDate = .now
        }
        
        do {
            tempChoices = try Choice.by(problem: problem).map { choice in
                return TempChoice(content: choice.content ?? "", isSelected: choice.isSelected)
            }
        } catch {
            errorMessage = "문제의 세부 정보를 불러오는데 실패했습니다.\n화면을 나갔다가 다시 들어오세요."
        }
    }
    
    // MARK: - 요약 파트
    @Published var title = "" {
        didSet {
            problem.title = title
        }
    }
    
    @Published var categoryVM: CategoryViewModel? {
        didSet {
            problem.category = self.categoryVM?.category
        }
    }
    
    @Published var isFinished = false {
        didSet {
            problem.finished = isFinished
        }
    }
    
    @Published var assessment = Assessment.notSure {
        didSet {
            problem.assessment = assessment
        }
    }
    
    // MARK: - 세부 파트
    @Published var situation = "" {
        didSet {
            problem.situation = situation
        }
    }
    
    @Published var tempChoices = [TempChoice]()
    var enumeratedTempChoices: [(Int, TempChoice)] {
        Array(tempChoices.enumerated())
    }
    
    @Published var reason = "" {
        didSet {
            problem.reason = reason
        }
    }
    
    @Published var result = "" {
        didSet {
            problem.result = result
        }
    }
    
    @Published var lesson = "" {
        didSet {
            problem.lesson = lesson
        }
    }
    
    // MARK: - 선택지 추가 alert
    @Published var newChoiceContent = ""
    @Published var addChoiceAlertIsPresented = false {
        didSet {
            if addChoiceAlertIsPresented {
                newChoiceContent = ""
            }
        }
    }
    
    private func addChoice(with content: String) {
        tempChoices.append(TempChoice(content: content, isSelected: false))
    }
    
    func addChoiceAlert(presented: Binding<Bool>) -> AlertModifierWithTextField {
        return AlertModifierWithTextField(presented: presented,
                                          title: "선택지 추가",
                                          message: "새롭게 추가할 선택지 내용을 입력하세요",
                                          okMessage: "추가",
                                          action: addChoice(with:))
    }
    
    // MARK: - 선택지 수정 alert
    @Published var modifiedChoiceContent = ""
    private var modifyingChoiceIndex = 0
    @Published var modifyChoiceAlertIsPresented = false {
        didSet {
            if modifyChoiceAlertIsPresented {
                modifiedChoiceContent = ""
            }
        }
    }
    
    private func modifyChoice(at index: Int, to newContent: String) {
        tempChoices[index].content = newContent
    }
    
    func modifyChoiceAlert(presented: Binding<Bool>) -> AlertModifierWithTextField {
        return AlertModifierWithTextField(presented: presented,
                                          title: "선택지 수정",
                                          message: "선택지의 내용을 수정하세요",
                                          okMessage: "수정") { input in
            self.modifyChoice(at: self.modifyingChoiceIndex, to: input)
        }
    }
    
    func alertAndModifyChoice(at index: Int) {
        modifyingChoiceIndex = index
        modifyChoiceAlertIsPresented = true
    }
    
    // MARK: - 선택지 제거 alert
    var deletingChoiceIndex = 0
    @Published var deleteChoiceAlertIsPresented = false
    
    private func deleteChoice(at index: Int) {
        tempChoices.remove(at: index)
    }
    
    func deleteChoiceAlert(presented: Binding<Bool>) -> AlertModifier {
        return AlertModifier(presented: presented,
                             title: "선택지 삭제",
                             message: "정말로 선택지를 삭제하시겠습니까?",
                             okMessage: "삭제", okStyle: .destructive) {
            self.deleteChoice(at: self.deletingChoiceIndex)
        }
    }
    
    func alertAndDeleteChoice(at index: Int) {
        deletingChoiceIndex = index
        deleteChoiceAlertIsPresented = true
    }
    
    // MARK: - 문제 저장
    func saveProblem() {
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch {
            errorMessage = "문제 저장에 실패하였습니다."
        }
    }
}
