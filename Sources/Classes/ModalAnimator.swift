//
//  ModalAnimator.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/20.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit

public class ModalAnimator {
    static var cornerRadius: CGFloat = 0

    public class func present(toView: UIView, fromView: UIView, toHeight: CGFloat?, completion: @escaping () -> Void) {

        let overlayView = UIView(frame: fromView.bounds)

        overlayView.backgroundColor = ShariSettings.backgroundColorOfOverlayView
        overlayView.isUserInteractionEnabled = true
        overlayView.tag = InternalStructureViewType.Overlay.rawValue
        overlayView.accessibilityLabel = "ShariOverlayView"
        fromView.addSubview(overlayView)

        self.addScreenShotView(capturedView: fromView, screenshotContainer: overlayView)

        var toViewStartFrame = fromView.bounds.offsetBy(dx: 0, dy: fromView.bounds.size.height)
        toViewStartFrame.size.height = 0
        toView.frame = toViewStartFrame
        toView.tag = InternalStructureViewType.ToView.rawValue
        fromView.addSubview(toView)

        UIView.animate(
            withDuration: 0.2,
            animations: { () -> Void in

                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                var toViewFrame: CGRect = .zero
                if let toHeight = toHeight {
                    toViewFrame = fromView.bounds.offsetBy(dx: 0, dy: fromView.bounds.size.height - toHeight)
                    toViewFrame.size.height = toHeight
                } else {
                    toViewFrame = fromView.bounds.offsetBy(dx: 0, dy: statusBarHeight + fromView.bounds.size.height / 2.0)
                    toViewFrame.size.height -= toViewFrame.origin.y
                }
                toView.frame = toViewFrame

                toView.alpha = 1.0

        }, completion: { _ -> Void in
            completion()
        })
    }

    public class func overlayView(fromView: UIView) -> UIView? {
        return fromView.viewWithTag(InternalStructureViewType.Overlay.rawValue)
    }
    
    public class func modalView(fromView: UIView) -> UIView? {
        return fromView.viewWithTag(InternalStructureViewType.ToView.rawValue)
    }
    
    public class func screenShotView(overlayView: UIView) -> UIImageView {
        let tag = InternalStructureViewType.ScreenShot.rawValue
        guard let view = overlayView.viewWithTag(tag) as? UIImageView else {
            fatalError("Invalid ScreenShotView")
        }
        return view
    }
    
    public class func dismiss(fromView: UIView, presentingViewController: UIViewController?, completion: @escaping () -> Void) {
        
        let targetView = fromView
        let modalView = ModalAnimator.modalView(fromView: fromView)
        let overlayView = ModalAnimator.overlayView(fromView: fromView)
        overlayView?.alpha = 1.0

        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            
            modalView?.frame = CGRect(
                x: (targetView.bounds.size.width - modalView!.frame.size.width) / 2.0,
                y: targetView.bounds.size.height,
                width: modalView!.frame.width,
                height: modalView!.frame.height)
            
        }, completion: { _ -> Void in
            overlayView?.removeFromSuperview()
            modalView?.removeFromSuperview()
        })

        // Begin Overlay Animation
        if overlayView != nil {
            
            guard let screenShotView = overlayView?.subviews[0] as? UIImageView else {
                fatalError("Invalid ScreenShotView")
            }
            screenShotView.layer.add(self.animationGroupForward(forward: false), forKey: "bringForwardAnimation")
            
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: { () -> Void in
                
                screenShotView.alpha = 1.0
                
                }, completion: { _ -> Void in
                    
                    completion()
            })
        }
    }
    
    public class func transitionBackgroundView(overlayView: UIView, location: CGPoint) {
        
        if !ShariSettings.shouldTransformScaleDown {
            return
        }
        
        let screenShotView = ModalAnimator.screenShotView(overlayView: overlayView)
        let scale = self.map(value: location.y, inMin: 0, inMax: UIScreen.main.bounds.height, outMin: 0.7757, outMax: 1.0)
        let transform = CATransform3DMakeScale(scale, scale, 1)
        screenShotView.layer.removeAllAnimations()
        screenShotView.layer.transform = transform
        screenShotView.setNeedsLayout()
        screenShotView.layoutIfNeeded()
    }
    
    // MARK: - Private
    
    class func addScreenShotView(capturedView: UIView, screenshotContainer: UIView) {
        
        screenshotContainer.isHidden = true
        
        UIGraphicsBeginImageContextWithOptions(capturedView.bounds.size, false, UIScreen.main.scale)
        capturedView.drawHierarchy(in: capturedView.bounds, afterScreenUpdates: false)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        screenshotContainer.isHidden = false
        
        let screenshot = UIImageView(image: image)
        screenshot.tag = InternalStructureViewType.ScreenShot.rawValue
        screenshot.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        screenshotContainer.addSubview(screenshot)

        if cornerRadius > 0 {
            screenshot.layer.cornerRadius = cornerRadius
            screenshot.clipsToBounds = true
        }

        screenshot.layer.add(self.animationGroupForward(forward: true), forKey: "pushedBackAnimation")
        UIView.animate(withDuration: 0.2) { () -> Void in
            screenshot.alpha = 0.5
        }
    }
    
    class func animationGroupForward(forward: Bool) -> CAAnimationGroup {
        
        var transform = CATransform3DIdentity
        
        if ShariSettings.shouldTransformScaleDown {
            transform = CATransform3DScale(transform, 0.90, 0.90, 1.0)
        } else {
            transform = CATransform3DScale(transform, 1.0, 1.0, 1.0)
        }
        
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "transform")
        
        if forward {
            animation.toValue = NSValue(caTransform3D: transform)
        } else {
            animation.toValue = NSValue(caTransform3D: CATransform3DIdentity)
        }
        
        animation.duration = 0.2
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        
        let group = CAAnimationGroup()
        group.fillMode = CAMediaTimingFillMode.forwards
        group.isRemovedOnCompletion = false
        group.duration = animation.duration
        
        group.animations = [animation]
        return group
    }
    
    class func map(value: CGFloat, inMin: CGFloat, inMax: CGFloat, outMin: CGFloat, outMax: CGFloat) -> CGFloat {
        
        let inRatio = value / (inMax - inMin)
        let outRatio = (outMax - outMin) * inRatio + outMin
        
        return outRatio
    }
}
