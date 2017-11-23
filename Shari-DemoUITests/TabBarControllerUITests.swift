//
//  TabBarControllerUITests.swift
//  Shari-Demo
//
//  Created by nakajijapan on 2016/10/19.
//  Copyright © 2016年 nakajijapan. All rights reserved.
//

import XCTest

class TabBarControllerUITests: XCTestCase {
    
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
        app.tabBars.buttons["TabBar"].tap()
        app.buttons["Button"].tap()
        app.navigationBars["modal"].buttons["Close"].tap()
        
    }
    
    func testShowAndSelect() {
        
        let app = XCUIApplication()
        app.tabBars.buttons["TabBar"].tap()
        app.buttons["Button"].tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Title #0"].tap()
        
    }
    
}
