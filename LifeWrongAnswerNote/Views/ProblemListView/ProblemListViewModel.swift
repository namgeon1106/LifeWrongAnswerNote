//
//  ProblemListViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/10.
//

import Foundation
import CoreData

class ProblemListViewModel: ObservableObject {
    @Published var problemVMs = [ProblemViewModel]()
    var enumeratedProblemVMs: [(Int, ProblemViewModel)] {
        Array(problemVMs.enumerated())
    }
    
    @Published var categoryVM: CategoryViewModel? {
        didSet {
            showFilteredProblems()
        }
    }
    @Published var isFinished: Bool? {
        didSet {
            showFilteredProblems()
        }
    }
    var isFinishedText: String {
        if let isFinished {
            return isFinished ? "완료" : "진행 중"
        } else {
            return "진행상태"
        }
    }
    
    @Published var searchText = "" {
        didSet {
            showFilteredProblems()
        }
    }
    
    @Published var deletable = false
    
    @Published var errorAlertIsPresented = false
    @Published var errorMessage = "" {
        didSet {
            errorAlertIsPresented = true
        }
    }
    
    func showFilteredProblems() {
        do {
            problemVMs = []
            
            let filteredResult = try Problem.by(category: categoryVM?.category, isFinished: isFinished, searchText: searchText)
                .map(ProblemViewModel.init(problem:))
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.problemVMs = filteredResult
            }
        } catch {
            errorMessage = "문제 목록을 가져오는데 실패하였습니다."
        }
    }
}
