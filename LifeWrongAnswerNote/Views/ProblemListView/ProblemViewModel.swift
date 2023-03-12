//
//  ProblemViewModel.swift
//  LifeWrongAnswerNote
//
//  Created by 김남건 on 2022/12/08.
//

import Foundation

struct ProblemViewModel {
    let problem: Problem
    
    var title: String {
        problem.title ?? ""
    }
    
    var assessment: Assessment {
        problem.assessment
    }
    
    var categoryName: String {
        problem.category?.name ?? "카테고리 없음"
    }
    
    var finishedInfo: String {
        problem.finished ? "완료" : "진행 중"
    }
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy.MM.dd"
        
        return dateFormatter.string(from: problem.createdDate ?? .now)
    }
    
    func delete() throws {
        problem.delete()
        
        try CoreDataManager.shared.viewContext.save()
    }
}
