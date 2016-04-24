//
//  Shari_DemoUITests.swift
//  Shari-DemoUITests
//
//  Created by nakajijapan on 2016/02/03.
//  Copyright © 2016年 nakajijapan. All rights reserved.
//

import XCTest

class Shari_DemoUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testShowAndClose() {
        
        let app = XCUIApplication()
        app.tables.staticTexts["Detail View Controller"].tap()
        app.buttons["Button"].tap()
        app.navigationBars["modal"].buttons["Close"].tap()
        
    }
    
    func testShowAndSelect() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Detail View Controller"].tap()
        app.buttons["Button"].tap()
        tablesQuery.staticTexts["Title #0"].tap()
        
    }
    
    func testCloseWhenTappingBackgroundView() {
        
        let app = XCUIApplication()
        app.tables.staticTexts["Detail View Controller"].tap()
        app.buttons["Button"].tap()
        app.otherElements.containingType(.NavigationBar, identifier:"Shari.Navigation").childrenMatchingType(.Other).elementBoundByIndex(1).childrenMatchingType(.Image).element.tap()
        
    }
    
    
}
