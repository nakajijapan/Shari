//
//  ShariTests.swift
//  ShariTests
//
//  Created by nakajijapan on 2016/11/12.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit
import XCTest
@testable import Shari

class ShariTests: XCTestCase {
    
    func testSetting() {
        XCTAssertEqual(ShariSettings.backgroundColorOfOverlayView, UIColor(red: 0, green: 0, blue: 0, alpha: 1.0))
        XCTAssertEqual(ShariSettings.shouldTransformScaleDown, true)
        XCTAssertEqual(ShariSettings.isUsingScreenShotImage, true)
    }

    func testMap() {

        var value = ModalAnimator.map(value: 400, inMin: 0, inMax: 800, outMin: 0.0, outMax: 1.0)
        XCTAssertEqual(value, 0.5)

        value = ModalAnimator.map(value: 400, inMin: 0, inMax: 800, outMin: 0.5, outMax: 1.0)
        XCTAssertEqual(value, 0.75)

        value = ModalAnimator.map(value: 450, inMin: 0, inMax: 800, outMin: 0.9, outMax: 1.0)
        XCTAssertEqual(value, 0.95625)

        value = ModalAnimator.map(value: 450, inMin: 0, inMax: 812, outMin: 0.7757, outMax: 1.0)
        XCTAssertGreaterThan(value, 0.9)
    }

}
