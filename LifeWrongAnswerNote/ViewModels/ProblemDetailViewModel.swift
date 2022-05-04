//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/04.
//

import Foundation

class ProblemDetailViewModel: ObservableObject {
    var title = ""
    var category: Category? = nil
    var assessment = Assessment.notSure
    var situation = ""
    var chosen: Choice? = nil
    var reason = ""
    var result = ""
    var retrospection = ""
    
    func addProblem() {
        let problem = Problem(context: Problem.viewContext)
        problem.setValues(title: title, category: category, assessment: assessment, situation: situation, chosen: chosen, reason: reason, result: result, retrospection: retrospection, date: Date())
    }
    
    func modifyProblem(problemVM: ProblemViewModel) {
        let problem = Problem.byId(id: problemVM.id) as? Problem
        
        if let problem = problem {
            problem.setValues(title: title, category: category, assessment: assessment, situation: situation, chosen: chosen, reason: reason, result: result, retrospection: retrospection, date: problem.date!)
        }
    }
}
