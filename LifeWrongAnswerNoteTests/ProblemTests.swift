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
    var problem: Problem!

    override class func setUp() {
        CoreDataManager.shared.load(forTest: true)
    }
    
    override func setUpWithError() throws {
        viewContext = CoreDataManager.shared.viewContext
    }

    override func tearDownWithError() throws {
        let problems = try! viewContext.fetch(Problem.fetchRequest())
        problems.forEach { $0.delete() }
        
        let categories = try! viewContext.fetch(Category.fetchRequest())
        categories.forEach { $0.delete() }
        
        try! viewContext.save()
    }
    
    // MARK: - by(category:isFinished:searchText:)
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
        problem2.finished = true
        problem2.title = "problem2"
        
        let problem3 = Problem(context: viewContext)
        problem3.createdDate = .now
        problem3.title = "problem3"
    }

    func testBy_whenAllParametersAreNilOrEmpty_returnsAllProblems() {
        // given
        givenThreeProblemsAndTwoCategories()
        
        // when
        let sut = try! Problem.by(category: nil, isFinished: nil, searchText: "")
        let titles = sut.compactMap(\.title).sorted()
        
        // then
        XCTAssertEqual(titles, ["problem1", "problem2", "problem3"])
    }
    
    func testBy_whenCategoryIsNotNil_returnsFilteredProblems() {
        // given
        givenThreeProblemsAndTwoCategories()
        
        // when
        let sut = try! Problem.by(category: category1, isFinished: nil, searchText: "")
        let titles = sut.compactMap(\.title).sorted()
        
        // then
        XCTAssertEqual(titles, ["problem1"])
    }
    
    func testBy_whenIsFinishedIsNotNil_returnsFilteredProblems() {
        // given
        givenThreeProblemsAndTwoCategories()
        
        // when
        let sut = try! Problem.by(category: nil, isFinished: false, searchText: "")
        let titles = sut.compactMap(\.title).sorted()
        
        // then
        XCTAssertEqual(titles, ["problem1", "problem3"])
    }
    
    func testBy_whenSearchTextIsNotEmpty_returnsFilteredProblems() {
        // given
        givenThreeProblemsAndTwoCategories()
        
        // when
        let sut = try! Problem.by(category: nil, isFinished: nil, searchText: "blem2")
        let titles = sut.compactMap(\.title).sorted()
        
        // then
        XCTAssertEqual(titles, ["problem2"])
    }
    
    func testBy_whenMultipleFiltersApplied_returnsFilteredProblems() {
        // given
        givenThreeProblemsAndTwoCategories()
        
        // when
        let sut = try! Problem.by(category: category2, isFinished: true, searchText: "pro")
        let titles = sut.compactMap(\.title).sorted()
        
        // then
        XCTAssertEqual(titles, ["problem2"])
    }
    
    // MARK: - assessment getter & setter
    func givenOneProblem() {
        // given
        problem = Problem(context: viewContext)
        problem.createdDate = .now
    }
    
    func testAssessment_whenGet_returnsAssessmentWithRawValue() {
        // given
        givenOneProblem()
        problem.assessmentRawValue = 1
        try! viewContext.save()
        
        // when
        let sut = problem.assessment
        
        // then
        XCTAssertEqual(sut, .good)
    }
    
    func testAssessment_whenSet_changeAssessmentRawValue() {
        // given
        givenOneProblem()
        problem.assessment = .soso
        try! viewContext.save()
        
        // when
        let sut = problem.assessmentRawValue
        
        // then
        XCTAssertEqual(sut, Assessment.soso.rawValue)
    }
}
