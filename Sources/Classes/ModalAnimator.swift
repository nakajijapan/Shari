//
//  ModalAnimator.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/20.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit

public class ModalAnimator {
    
    public class func present(toView: UIView, fromView: UIView, completion: () -> Void) {
        
        let overlayView = UIView(frame: fromView.bounds)
        
        overlayView.backgroundColor = BackgroundColorOfOverlayView
        overlayView.userInteractionEnabled = true
        overlayView.tag = InternalStructureViewType.Overlay.rawValue
        fromView.addSubview(overlayView)
        
        self.addScreenShotView(fromView, screenshotContainer: overlayView)
        
        var toViewFrame = CGRectOffset(fromView.bounds, 0, fromView.bounds.size.height)
        toViewFrame.size.height = 0
        toView.frame = toViewFrame
        
        toView.tag = InternalStructureViewType.ToView.rawValue
        fromView.addSubview(toView)
        
        UIView.animateWithDuration(
            0.2,
            animations: { () -> Void in
                
                let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
                var toViewFrame = CGRectOffset(fromView.bounds, 0, statusBarHeight + fromView.bounds.size.height / 2.0)
                toViewFrame.size.height -= toViewFrame.origin.y
                toView.frame = toViewFrame
                
                toView.alpha = 1.0
                
        }) { (result) -> Void in
            
            completion()
            
        }
        
    }
    
    public class func overlayView(fromView: UIView) -> UIView? {
        return fromView.viewWithTag(InternalStructureViewType.Overlay.rawValue)
    }
    
    public class func modalView(fromView: UIView) -> UIView? {
        return fromView.viewWithTag(InternalStructureViewType.ToView.rawValue)
    }
    
    public class func screenShotView(overlayView: UIView) -> UIImageView {
        return overlayView.viewWithTag(InternalStructureViewType.ScreenShot.rawValue) as! UIImageView
    }
    
    
    public class func dismiss(fromView: UIView, presentingViewController: UIViewController?, completion: () -> Void) {
        
        let targetView = fromView
        let modalView = ModalAnimator.modalView(fromView)
        let overlayView = ModalAnimator.overlayView(fromView)
        overlayView?.alpha = 1.0
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            
            modalView?.frame = CGRectMake(
                (targetView.bounds.size.width - modalView!.frame.size.width) / 2.0,
                targetView.bounds.size.height,
                (modalView?.frame.size.width)!,
                (modalView?.frame.size.height)!);
            
        }) { (result) -> Void in
            
            overlayView?.removeFromSuperview()
            modalView?.removeFromSuperview()
            
            // Remove Modal View Controller
            presentingViewController?.removeFromParentViewController()
        }
        
        // Begin Overlay Animation
        if overlayView != nil {
            
            let screenShotView = overlayView?.subviews[0] as! UIImageView
            screenShotView.layer.addAnimation(self.animationGroupForward(false), forKey: "bringForwardAnimation")
            
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                
                screenShotView.alpha = 1.0
                
                }, completion: { (result) -> Void in
                    
                    completion()
                    
            })
            
        }
        
    }
    
    public class func transitionBackgroundView(overlayView: UIView, location:CGPoint) {
        
        if !ShouldTransformScaleDown {
            return;
        }
        
        let screenShotView = ModalAnimator.screenShotView(overlayView)
        let scale = self.map(location.y, inMin: 0, inMax: UIScreen.mainScreen().bounds.height, outMin: 0.9, outMax: 1.0)
        let transform = CATransform3DMakeScale(scale, scale, 1)
        screenShotView.layer.removeAllAnimations()
        screenShotView.layer.transform = transform
        screenShotView.setNeedsLayout()
        screenShotView.layoutIfNeeded()
        
    }
    
    // MARK - Private
    
    class func addScreenShotView(capturedView: UIView, screenshotContainer:UIView) {
        
        screenshotContainer.hidden = true
        
        UIGraphicsBeginImageContextWithOptions(capturedView.bounds.size, false, UIScreen.mainScreen().scale)
        let context = UIGraphicsGetCurrentContext()!
        CGContextTranslateCTM(context, -capturedView.bounds.origin.x, -capturedView.bounds.origin.y)
        capturedView.layer.renderInContext(context)

        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        screenshotContainer.hidden = false
        
        let screenshot = UIImageView(image: image)
        screenshot.tag = InternalStructureViewType.ScreenShot.rawValue
        screenshot.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        screenshotContainer.addSubview(screenshot)
        
        screenshot.layer.addAnimation(self.animationGroupForward(true), forKey:"pushedBackAnimation")
        UIView.animateWithDuration(0.2) { () -> Void in
            screenshot.alpha = 0.5
        }
        
        
    }
    
    class func animationGroupForward(forward:Bool) -> CAAnimationGroup {
        
        var transform = CATransform3DIdentity
        
        if ShouldTransformScaleDown {
            transform = CATransform3DScale(transform, 0.95, 0.95, 1.0);
        } else {
            transform = CATransform3DScale(transform, 1.0, 1.0, 1.0);
        }
        
        let animation:CABasicAnimation = CABasicAnimation(keyPath: "transform")
        
        if forward {
            animation.toValue = NSValue(CATransform3D:transform)
        } else {
            animation.toValue = NSValue(CATransform3D:CATransform3DIdentity)
        }
        
        animation.duration = 0.2
        animation.fillMode = kCAFillModeForwards
        animation.removedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        
        let group = CAAnimationGroup()
        group.fillMode = kCAFillModeForwards
        group.removedOnCompletion = false
        group.duration = animation.duration
        
        group.animations = [animation]
        return group
    }
    
    
    class func map(value:CGFloat, inMin:CGFloat, inMax:CGFloat, outMin:CGFloat, outMax:CGFloat) -> CGFloat {
        
        let inRatio = value / (inMax - inMin)
        let outRatio = (outMax - outMin) * inRatio + outMin
        
        return outRatio
    }
    
    
}
