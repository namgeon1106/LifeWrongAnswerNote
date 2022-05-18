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
    
    init(problemVM: ProblemViewModel?) {
        if let problemVM = problemVM {
            _titleInput = Published<String>(initialValue: problemVM.title)
            _categoryInput = Published<CategoryViewModel?>(initialValue: problemVM.category != nil ? CategoryViewModel(category: problemVM.category!) : nil)
            _finishedInput = Published<Bool>(initialValue: problemVM.finished)
            _assessmentInput = Published<Assessment>(initialValue: problemVM.assessment)
            
            situationInput = problemVM.situation
            reasonInput = problemVM.reason
            resultInput = problemVM.result
            retrospectionInput = problemVM.retrospection
        }
    }
    
    
}
