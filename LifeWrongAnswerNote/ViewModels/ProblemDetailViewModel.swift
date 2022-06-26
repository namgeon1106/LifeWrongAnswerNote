//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/18.
//

import Foundation
import CoreData

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
    
    let originalChoiceList: ChoiceList // 기존에 저장되어 있는 ChoiceList
    let temporaryChoiceList: ChoiceList // 수정을 위해 사용할 ChoiceList
    
    @Published var originalChoiceVMs = [ChoiceViewModel]()
    @Published var temporaryChoiceVMs = [ChoiceViewModel]()
    
    init(problemVM: ProblemViewModel?) {
        self.problemVM = problemVM
        
        if let problemVM = problemVM {
            _titleInput = Published(initialValue: problemVM.title)
            _categoryInput = Published(initialValue: problemVM.category != nil ? CategoryViewModel(category: problemVM.category!) : nil)
            _finishedInput = Published(initialValue: problemVM.finished)
            _assessmentInput = Published(initialValue: problemVM.assessment)
            
            situationInput = problemVM.situation
            reasonInput = problemVM.reason
            resultInput = problemVM.result
            retrospectionInput = problemVM.retrospection
            
            _editable = Published(initialValue: false)
        }
        
        originalChoiceList = ChoiceList.byProblem(problem: self.problemVM!.problem) ?? ChoiceList(context: CoreDataManager.shared.viewContext)
        originalChoiceList.problem = self.problemVM!.problem
        temporaryChoiceList = ChoiceList(context: CoreDataManager.shared.viewContext)
        temporaryChoiceList.problem = self.problemVM!.problem
        
        CoreDataManager.shared.save()
        
        _originalChoiceVMs = Published(wrappedValue: Choice.byChoiceList(originalChoiceList).map { ChoiceViewModel(choice: $0) })
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
    
    func copyChoicesToTemporary() {
        for choiceVM in originalChoiceVMs {
            let copiedChoice = Choice(context: CoreDataManager.shared.viewContext)
            copiedChoice.problem = problemVM?.problem
            copiedChoice.choiceList = temporaryChoiceList
            copiedChoice.content = choiceVM.choice.content
            
            temporaryChoiceVMs.append(ChoiceViewModel(choice: copiedChoice))
        }
        
        CoreDataManager.shared.save()
    }
    
    func addChoice(content: String) {
        let newChoice = Choice(context: CoreDataManager.shared.viewContext)
        newChoice.content = content
        newChoice.choiceList = temporaryChoiceList
        newChoice.problem = problemVM?.problem
        
        CoreDataManager.shared.save()
        temporaryChoiceVMs.append(ChoiceViewModel(choice: newChoice))
    }
    
    func saveProblem() {
        if problemVM == nil {
            addProblem()
        } else {
            setProblem()
        }
    }
}

struct ChoiceViewModel {
    let choice: Choice
    
    var id: NSManagedObjectID {
        choice.objectID
    }
    
    var content: String {
        choice.content ?? ""
    }
}
