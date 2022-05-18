//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/18.
//

import Foundation

class ProblemDetailViewModel: ObservableObject {
    var problemVM: ProblemViewModel?
    
    @Published var titleInput = ""
    @Published var categoryInput: CategoryViewModel?
    @Published var finishedInput = false
    @Published var assessmentInput = Assessment.notSure
    
    var situationInput = ""
    var reasonInput = ""
    var resultInput = ""
    var retrospectionInput = ""
    
    @Published var editable = true
    
    init(problemVM: ProblemViewModel?) {
        self.problemVM = problemVM
        
        if let problemVM = problemVM {
            _titleInput = Published<String>(initialValue: problemVM.title)
            _categoryInput = Published<CategoryViewModel?>(initialValue: problemVM.category != nil ? CategoryViewModel(category: problemVM.category!) : nil)
            _finishedInput = Published<Bool>(initialValue: problemVM.finished)
            _assessmentInput = Published<Assessment>(initialValue: problemVM.assessment)
            
            situationInput = problemVM.situation
            reasonInput = problemVM.reason
            resultInput = problemVM.result
            retrospectionInput = problemVM.retrospection
            
            _editable = Published<Bool>(initialValue: false)
        }
    }
    
    func addProblem() {
        problemVM = ProblemViewModel(problem: Problem(context: CoreDataManager.shared.viewContext))
        problemVM!.problem.date = Date()
        setProblem()
    }
    
    func setProblem() {
        problemVM!.problem.title = titleInput
        problemVM!.problem.category = categoryInput?.category
        problemVM!.problem.finished = finishedInput
        problemVM!.problem.assessment = assessmentInput.rawValue
        problemVM!.problem.situation = situationInput
        problemVM!.problem.reason = reasonInput
        problemVM!.problem.result = resultInput
        problemVM!.problem.retrospection = retrospectionInput
        
        CoreDataManager.shared.save()
        editable = false
    }
    
    func saveProblem() {
        if problemVM == nil {
            addProblem()
        } else {
            setProblem()
        }
    }
}
