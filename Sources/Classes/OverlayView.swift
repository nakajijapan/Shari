//
//  OverlayView.swift
//  Shari
//
//  Created by Daichi Nakajima on 2018/10/20.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

struct ShariOptions {
    let height: CGFloat?
    let useScreenShot: Bool
}

class OverlayView: UIView {
    var options: ShariOptions!

    init(frame: CGRect, options: ShariOptions) {
        super.init(frame: frame)
        self.options = options
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
