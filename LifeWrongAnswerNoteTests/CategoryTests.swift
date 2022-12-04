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
        let allCagetories = try! viewContext.fetch(Category.fetchRequest())
        
        
        for cagetory in allCagetories {
            try! cagetory.delete()
        }
    }
    
    func testByName_whenMatchingCategoryExists_returnsAnInstance() {
        // given
        let category1 = Category(context: viewContext)
        category1.name = "category1"
        
        let category2 = Category(context: viewContext)
        category2.name = "category2"
        
        try! viewContext.save()
        
        // when
        let sut = try! Category.by(name: "category1")
        
        // then
        XCTAssertEqual(sut?.name, category1.name)
    }
    
    func testByName_whenNoMatchingCategory_retunrsNil() {
        // given
        let category1 = Category(context: viewContext)
        category1.name = "category1"
        
        let category2 = Category(context: viewContext)
        category2.name = "category2"
        
        try! viewContext.save()
        
        // when
        let sut = try! Category.by(name: "category3")
        
        // then
        XCTAssertEqual(sut, nil)
    }
}
