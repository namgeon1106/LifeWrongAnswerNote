//
//  ProblemListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/18.
//

import Foundation

class ProblemListViewModel: ObservableObject {
    @Published var problemVMs = [ProblemViewModel]()
    
    func showFilteredProblems(categoryVM: CategoryViewModel?, finished: Bool?, searchText: String) {
        problemVMs = Problem.by(category: categoryVM?.category, finished: finished, searchText: searchText).map(ProblemViewModel.init(problem:))
    }
}

struct ProblemViewModel {
    let problem: Problem
    
    var title: String {
        problem.title!
    }
    
    var category: Category? {
        problem.category
    }
    
    var finished: Bool {
        problem.finished
    }
    
    var assessment: Assessment {
        Assessment(rawValue: problem.assessment)!
    }
    
    var situation: String {
        problem.situation!
    }
    
    var reason: String {
        problem.reason!
    }
    
    var result: String {
        problem.result!
    }
    
    var retrospection: String {
        problem.retrospection!
    }
}
