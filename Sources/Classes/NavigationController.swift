//
//  NavigationController.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/14.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit

@objc public protocol NavigationControllerDelegate {
    optional func navigationControllerDidSpreadToEntire(navigationController: UINavigationController)
}


public class NavigationController: UINavigationController {

    public var si_delegate: NavigationControllerDelegate?
    public var parentNavigationController: UINavigationController?
    var previousLocation = CGPointZero
    var originalLocation = CGPointZero

    override public func viewDidLoad() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "handlePanGesture:")
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
   
    func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let location = gestureRecognizer.locationInView(self.parentViewController!.view)
        let backgroundView = ModalAnimator.overlayView(self.parentNavigationController!.parentTargetView())!
        var degreeY:CGFloat = 0.0
        
        if (self.view.frame.origin.y + (location.y - previousLocation.y)) > UIApplication.sharedApplication().statusBarFrame.height {
            degreeY = location.y - previousLocation.y
        }

        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began :
            
            originalLocation = self.view.frame.origin
            break

        case UIGestureRecognizerState.Changed :
            
            var frame = self.view.frame
            frame.origin.y += degreeY
            self.view.frame = frame

            ModalAnimator.transitionBackgroundView(backgroundView, location: location)

            break

        case UIGestureRecognizerState.Ended :
            
            if (self.view.frame.minY < originalLocation.y) {
                
                UIView.animateWithDuration(
                    0.2,
                    animations: { () -> Void in
                        
                        var frame = self.view.frame
                        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
                        frame.origin.y = statusBarHeight
                        frame.size.height -= statusBarHeight
                        self.view.frame = frame
                        
                        ModalAnimator.transitionBackgroundView(backgroundView, location: self.view.frame.origin)
                        
                    }, completion: { (result) -> Void in
                        
                        UIView.animateWithDuration(
                            0.1,
                            delay: 0.0,
                            options: UIViewAnimationOptions.CurveLinear,
                            animations: { () -> Void in
                                backgroundView.alpha = 0.0
                            },
                            completion: { (result) -> Void in
                                
                                gestureRecognizer.enabled = false
                                self.si_delegate?.navigationControllerDidSpreadToEntire?(self)
                                
                            }
                        )
                    }
                )
                
            } else {
                

                UIView.animateWithDuration(
                    0.6,
                    delay: 0.0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.1,
                    options: UIViewAnimationOptions.CurveLinear,
                    animations: { () -> Void in
                        
                        ModalAnimator.transitionBackgroundView(backgroundView, location: self.originalLocation)
                        
                        var frame = self.view.frame
                        frame.origin.y = self.originalLocation.y
                        self.view.frame = frame
                        
                    },

                    completion: { (result) -> Void in

                        gestureRecognizer.enabled = true

                })
                
            }

            break

        default:
            break
            
        }
        
        self.previousLocation = location
        
    }
    
}
