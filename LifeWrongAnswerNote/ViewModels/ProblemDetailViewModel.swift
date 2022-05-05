//
//  ProblemDetailViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/05/04.
//

import Foundation
import CoreData

class ProblemDetailViewModel: ObservableObject {
    @Published var title = ""
    @Published var category: Category? = nil
    @Published var finished = false
    @Published var assessment = Assessment.notSure
    var situation = ""
    @Published var choiceVMs = [ChoiceViewModel]()
    var chosen: Choice? = nil
    var reason = ""
    var result = ""
    var retrospection = ""
    
    func addProblem() {
        let problem = Problem(context: Problem.viewContext)
        problem.setValues(title: title, category: category, finished: finished, assessment: assessment, situation: situation, chosen: chosen, reason: reason, result: result, retrospection: retrospection, date: Date())
        
        for choiceVM in choiceVMs {
            choiceVM.choice.problem = problem
            choiceVM.choice.save()
        }
    }
    
    func modifyProblem(problemVM: ProblemViewModel) {
        let problem = Problem.byId(id: problemVM.id) as? Problem
        
        if let problem = problem {
            problem.setValues(title: title, category: category, finished: finished, assessment: assessment, situation: situation, chosen: chosen, reason: reason, result: result, retrospection: retrospection, date: problem.date!)
        }
        
        for choiceVM in choiceVMs {
            choiceVM.choice.problem = problem
            choiceVM.choice.save()
        }
    }
    
    func getChoicesInProblem(problemVM: ProblemViewModel?) {
        var choiceArr: [Choice]
        if let problemVM = problemVM {
            choiceArr = Choice.getChoicesByProblemId(problemId: problemVM.id)
        } else {
            choiceArr = Choice.all().filter({ choice in
                choice.problem == nil
            })
        }
        
        choiceVMs = choiceArr.map(ChoiceViewModel.init(choice:))
    }
    
    func addChoice(content: String, problemVM: ProblemViewModel?) {
        let choice = Choice(context: Choice.viewContext)
        choice.content = content
        
        if let problemVM = problemVM {
            choice.problem = Problem.byId(id: problemVM.id)
        }
    }
    
    func modifyChoice(content: String, choiceVM: ChoiceViewModel, problemVM: ProblemViewModel?) {
        if(chosen?.objectID == choiceVM.id) {
            deleteChoice(choiceVM: choiceVM)
            addChoice(content: content, problemVM: problemVM)
            chosen = choiceVM.choice
        } else {
            deleteChoice(choiceVM: choiceVM)
            addChoice(content: content, problemVM: problemVM)
        }
    }
    
    func deleteChoice(choiceVM: ChoiceViewModel) {
        Choice.viewContext.delete(choiceVM.choice)
        if(chosen?.objectID == choiceVM.id) {
            chosen = nil
        }
    }
    
    func choose(choiceVM: ChoiceViewModel) {
        if(chosen?.objectID == choiceVM.choice.objectID) {
            chosen = nil
            return
        }
        
        chosen = choiceVM.choice
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
