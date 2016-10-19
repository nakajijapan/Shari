import UIKit
import XCTest
import Shari

class Tests: XCTestCase {
    
    func testSetting() {
        XCTAssertEqual(Shari.BackgroundColorOfOverlayView, UIColor.blackColor())
        XCTAssertEqual(Shari.ShouldTransformScaleDown, true)
    }
    
}
