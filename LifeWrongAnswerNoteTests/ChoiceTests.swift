//
//  ChoiceTests.swift
//  LifeWrongAnswerNoteTests
//
//  Created by 김남건 on 2022/12/04.
//

import XCTest
import CoreData
@testable import LifeWrongAnswerNote

final class ChoiceTests: XCTestCase {
    var viewContext: NSManagedObjectContext!
    
    override class func setUp() {
        CoreDataManager.shared.load(forTest: false)
    }
    
    override func setUpWithError() throws {
        viewContext = CoreDataManager.shared.viewContext
    }

    override func tearDownWithError() throws {
        let problems = try! viewContext.fetch(Problem.fetchRequest())
        problems.forEach { $0.delete() }
        
        let choices = try! viewContext.fetch(Choice.fetchRequest())
        choices.forEach { $0.delete() }
        
        try! viewContext.save()
    }
    
    func testByProblem_returnsChoicesOfOneProblem() {
        // given
        let problem1 = Problem(context: viewContext)
        problem1.createdDate = .now
        
        let problem2 = Problem(context: viewContext)
        problem2.createdDate = .now
        
        let choice1 = Choice(context: viewContext)
        choice1.content = "content1"
        choice1.problem = problem1
        
        let choice2 = Choice(context: viewContext)
        choice2.content = "content2"
        choice2.problem = problem1
        
        let choice3 = Choice(context: viewContext)
        choice3.content = "content3"
        choice3.problem = problem2
        
        let choice4 = Choice(context: viewContext)
        choice4.content = "content4"
        choice4.problem = problem2
        
        try! viewContext.save()
        
        // when
        let sut = try! Choice.by(problem: problem1)
        
        // then
        let contents = sut.compactMap(\.content).sorted()
        XCTAssertEqual(contents, ["content1", "content2"])
    }
}
