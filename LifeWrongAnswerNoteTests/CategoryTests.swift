//
//  LifeWrongAnswerNoteTests.swift
//  LifeWrongAnswerNoteTests
//
//  Created by 김남건 on 2022/12/04.
//

import XCTest
import CoreData
@testable import LifeWrongAnswerNote

final class CategoryTests: XCTestCase {
    var viewContext: NSManagedObjectContext!
    
    override class func setUp() {
        CoreDataManager.shared.load(forTest: true)
    }

    override func setUpWithError() throws {
        viewContext = CoreDataManager.shared.viewContext
    }

    override func tearDownWithError() throws {
        let categories = try! viewContext.fetch(Category.fetchRequest())
        
        categories.forEach { $0.delete() }
        
        try! viewContext.save()
    }
    
    func givenTwoCategories() {
        let category1 = Category(context: viewContext)
        category1.name = "category1"
        
        let category2 = Category(context: viewContext)
        category2.name = "category2"
        
        try! viewContext.save()
    }
    
    func testByName_whenMatchingCategoryExists_returnsAnInstance() {
        // given
        givenTwoCategories()
        
        // when
        let sut = try! Category.by(name: "category1")
        
        // then
        XCTAssertEqual(sut?.name, "category1")
    }
    
    func testByName_whenNoMatchingCategory_retunrsNil() {
        // given
        givenTwoCategories()
        
        // when
        let sut = try! Category.by(name: "category3")
        
        // then
        XCTAssertEqual(sut, nil)
    }
    
    func testBySearchText_whenSearchTextIsEmpty_returnsAllInstances() {
        // given
        givenTwoCategories()
        
        // when
        let sut = try! Category.by(searchText: "")
        
        // then
        let categoryNames = sut.compactMap(\.name).sorted()
        XCTAssertEqual(categoryNames, ["category1", "category2"])
    }
    
    func testBySearchText_whenSearchTextInNotEmpty_returnsFilteredInstances() {
        // given
        givenTwoCategories()
        
        // when
        let sut = try! Category.by(searchText: "gory1")
        
        // then
        let categoryNames = sut.compactMap(\.name).sorted()
        XCTAssertEqual(categoryNames, ["category1"])
    }
}
