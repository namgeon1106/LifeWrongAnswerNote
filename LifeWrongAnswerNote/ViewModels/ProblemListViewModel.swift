//
//  ProblemListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/18.
//

import Foundation
import CoreData

class ProblemListViewModel: ObservableObject {
    @Published var problemVMs = [ProblemViewModel]()
    let categoryListVM = CategoryListViewModel()
    @Published var categoryInput: CategoryViewModel?
    @Published var finishedInput: Bool?
    @Published var searchText = ""
    @Published var deletable = false
    
    func showFilteredProblems() {
        problemVMs = Problem.by(category: categoryInput?.category, finished: finishedInput, searchText: searchText).map(ProblemViewModel.init(problem:))
    }
    
    func deleteProblem(problemVM: ProblemViewModel) {
        AlertUtils.displayAlertView(title: "문제 삭제", message: "문제를 삭제하시겠습니까?", okMessage: "삭제", okStyle: .destructive) {
            CoreDataManager.shared.viewContext.delete(problemVM.problem)
            CoreDataManager.shared.save()
            self.showFilteredProblems()
        }
    }
}

struct ProblemViewModel {
    let problem: Problem
    
    var id: NSManagedObjectID {
        problem.objectID
    }
    
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
    
    var date: Date {
        problem.date!
    }
}
