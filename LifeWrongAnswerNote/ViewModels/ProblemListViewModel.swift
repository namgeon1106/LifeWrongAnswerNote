//
//  ProblemListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/03.
//

import Foundation
import CoreData

class ProblemListViewModel: ObservableObject {
    @Published var problemVMs = [ProblemViewModel]()
    
    func addProblem(title: String, category: Category, assessment: Assessment, situation: String, choices: [Choice], reason: String, result: String, retrospection: String) {
        let problem = Problem(context: Problem.viewContext)
        problem.setValues(title: title, category: category, assessment: assessment, situation: situation, choices: choices, reason: reason, result: result, retrospection: retrospection)
    }
    
    func modifyProblem(problemVM: ProblemViewModel, title: String, category: Category, assessment: Assessment, situation: String, choices: [Choice], reason: String, result: String, retrospection: String) {
        let problem = Problem.byId(id: problemVM.id) as? Problem
        
        if let problem = problem {
            problem.setValues(title: title, category: category, assessment: assessment, situation: situation, choices: choices, reason: reason, result: result, retrospection: retrospection)
        }
    }
}

struct ProblemViewModel {
    let problem: Problem
    
    var id: NSManagedObjectID {
        problem.objectID
    }
    
    var title: String {
        problem.title ?? "제목 없음"
    }
    
    var category: Category? {
        problem.category
    }
    
    var assessment: Assessment {
        Assessment(rawValue: problem.assessment)!
    }
    
    var situation: String {
        problem.situation ?? ""
    }
    
    var choices: [Choice] {
        []
    }
    
    var reason: String {
        problem.reason ?? ""
    }
    
    var result: String {
        problem.result ?? ""
    }
    
    var retrospection: String {
        problem.retrospection ?? ""
    }
}
