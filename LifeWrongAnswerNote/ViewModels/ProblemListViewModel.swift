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
    static var shared = ProblemListViewModel()
    
    func showAllProblems() {
        problemVMs = Problem.all().map(ProblemViewModel.init(problem:))
    }
    
    func deleteProblem(problemVM: ProblemViewModel) {
        let problem: Problem? = Problem.byId(id: problemVM.id)
        if let problem = problem {
            problem.delete()
        }
    }
    
    func showFilteredProblems(subString: String, categoryVM: CategoryViewModel?) {
        DispatchQueue.main.async {
            self.problemVMs = Problem.filteredBy(subString: subString, category: categoryVM?.category).map(ProblemViewModel.init(problem:))
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
    
    var chosen: Choice? {
        problem.chosen
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
    
    var date: Date {
        problem.date ?? Date()
    }
}
