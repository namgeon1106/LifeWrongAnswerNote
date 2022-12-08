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
    @Published var choices = [TempChoice]()
    @Published var reason = ""
    @Published var result = ""
    @Published var lesson = ""
    
    init(problemVM: ProblemViewModel?) {
        problem = problemVM?.problem ?? Problem(context: CoreDataManager.shared.viewContext)
        
        if problemVM == nil {
            problem.createdDate = .now
        }
    }
}
