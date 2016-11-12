//
//  ShariTests.swift
//  ShariTests
//
//  Created by nakajijapan on 2016/11/12.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
import Shari

class ShariTests: XCTestCase {
    
    func testSetting() {
        XCTAssertEqual(Shari.BackgroundColorOfOverlayView, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        XCTAssertEqual(Shari.ShouldTransformScaleDown, true)
    }
    
}
