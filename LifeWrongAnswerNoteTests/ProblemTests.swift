//
//  ProblemTests.swift
//  LifeWrongAnswerNoteTests
//
//  Created by 김남건 on 2022/12/04.
//

import XCTest
import CoreData
@testable import LifeWrongAnswerNote

final class ProblemTests: XCTestCase {
    var viewContext: NSManagedObjectContext!
    var category1: LifeWrongAnswerNote.Category!
    var category2: LifeWrongAnswerNote.Category!

    override class func setUp() {
        CoreDataManager.shared.load(forTest: true)
    }
    
    override func setUpWithError() throws {
        viewContext = CoreDataManager.shared.viewContext
        givenThreeProblemsAndTwoCategories()
    }

    override func tearDownWithError() throws {
        let problems = try! viewContext.fetch(Problem.fetchRequest())
        problems.forEach { $0.delete() }
        
        let categories = try! viewContext.fetch(Category.fetchRequest())
        categories.forEach { $0.delete() }
        
        try! viewContext.save()
    }
    
    func givenThreeProblemsAndTwoCategories() {
        category1 = Category(context: viewContext)
        category2 = Category(context: viewContext)
        
        let problem1 = Problem(context: viewContext)
        problem1.createdDate = .now
        problem1.category = category1
        problem1.title = "problem1"

        let problem2 = Problem(context: viewContext)
        problem2.createdDate = .now
        problem2.category = category2
        problem2.title = "problem2"
        
        let problem3 = Problem(context: viewContext)
        problem3.createdDate = .now
        problem3.title = "problem3"
    }

    func testBy_whenAllParametersAreNilOrEmpty_returnsAllProblems() {
        // when
        let sut = try! Problem.by(category: nil, isFinished: nil, searchText: "")
        let titles = sut.compactMap(\.title).sorted()
        
        // then
        XCTAssertEqual(titles, ["problem1", "problem2", "problem3"])
    }

}
