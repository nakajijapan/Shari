//
//  LineButton.swift
//  Shari-Demo
//
//  Created by Daichi Nakajima on 2019/09/12.
//  Copyright © 2019 nakajijapan. All rights reserved.
//

import UIKit

public class LineButton: UIButton {

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayouts()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayouts()
    }

    private func setupLayouts() {
        tintColor = UIColor.lightGray
        let normalImage = UIImage(named: "Line")
        setImage(normalImage, for: UIControl.State.normal)
        imageEdgeInsets.top = -8
    }

}
