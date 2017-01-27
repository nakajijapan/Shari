//
//  NavigationControllerUITests.swift
//  Shari-DemoUITests
//
//  Created by nakajijapan on 2016/02/03.
//  Copyright © 2016年 nakajijapan. All rights reserved.
//

import XCTest

class NavigationControllerUITests: XCTestCase {
        
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
        app.otherElements.containing(.navigationBar, identifier:"Shari.Navigation").children(matching: .other).element(boundBy: 1).children(matching: .image).element.tap()
        
    }

}
