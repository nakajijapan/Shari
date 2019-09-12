//
//  LineView.swift
//  Shari-Demo
//
//  Created by Daichi Nakajima on 2019/09/11.
//  Copyright © 2019 nakajijapan. All rights reserved.
//

import UIKit

public class LineView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawLine(onLayer: layer, fromPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 50, y: 0))
    }
    
    func drawLine(onLayer layer: CALayer, fromPoint start: CGPoint, toPoint end: CGPoint) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.fillColor = nil
        line.opacity = 1.0
        line.lineWidth = 6
        line.strokeColor = UIColor.lightGray.cgColor
        line.lineCap = CAShapeLayerLineCap.round
        
        layer.addSublayer(line)
    }
}
