//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/08.
//

import Foundation

class ProblemDetailViewModel: ObservableObject {
    private let problem: Problem
    
    @Published var title = ""
    @Published var categoryVM: CategoryViewModel?
    @Published var isFinished = false
    @Published var assessment = Assessment.notSure
    
    @Published var situation = ""
    @Published var tempChoices = [TempChoice]()
    @Published var reason = ""
    @Published var result = ""
    @Published var lesson = ""
    
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
}
