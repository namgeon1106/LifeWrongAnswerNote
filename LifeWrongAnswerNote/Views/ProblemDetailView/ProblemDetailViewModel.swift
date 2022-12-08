//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/08.
//

import Foundation

class ProblemDetailViewModel: ObservableObject {
    private let problem: Problem
    
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
    
    @Published var errorAlertIsPresented = false
    @Published var errorMessage = "" {
        didSet {
            errorAlertIsPresented = true
        }
    }
    
    @Published var newChoiceContent = ""
    @Published var addChoiceAlertIsPresented = false {
        didSet {
            if addChoiceAlertIsPresented {
                newChoiceContent = ""
            }
        }
    }
    
    @Published var modifiedChoiceContent = ""
    var modifyingChoiceIndex = 0
    @Published var modifyChoiceAlertIsPresented = false {
        didSet {
            if modifyChoiceAlertIsPresented {
                modifiedChoiceContent = ""
            }
        }
    }
    
    var deletingChoiceIndex = 0
    @Published var deleteChoiceAlertIsPresented = false
    
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
    
    func addChoice() {
        tempChoices.append(TempChoice(content: newChoiceContent, isSelected: false))
    }
    
    func modifyChoice() {
        tempChoices[modifyingChoiceIndex].content = modifiedChoiceContent
    }
    
    func deleteChoice() {
        tempChoices.remove(at: deletingChoiceIndex)
    }
}
