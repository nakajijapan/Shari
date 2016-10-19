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
    public var parentTabBarController: UITabBarController?
    
    public var minDeltaUpSwipe: CGFloat = 50
    public var minDeltaDownSwipe: CGFloat = 50
    
    public var dismissControllSwipeDown = false
    public var fullScreenSwipeUp = true
    
    var previousLocation = CGPointZero
    var originalLocation = CGPointZero
    var originalFrame = CGRectZero
        
    override public func viewDidLoad() {
        originalFrame = self.view.frame
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(NavigationController.handlePanGesture(_:)))
        self.view.addGestureRecognizer(panGestureRecognizer)
    }
   
    func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
        
        let location = gestureRecognizer.locationInView(parentViewController!.view)
        let backgroundView = ModalAnimator.overlayView(parentTargetView())!
        let degreeY = location.y - self.previousLocation.y

        switch gestureRecognizer.state {
        case UIGestureRecognizerState.Began:
            
            originalLocation = self.view.frame.origin
            break

        case UIGestureRecognizerState.Changed:
            
            var frame = self.view.frame
            frame.origin.y += degreeY
            frame.size.height += -degreeY
            self.view.frame = frame

            ModalAnimator.transitionBackgroundView(backgroundView, location: location)

            break

        case UIGestureRecognizerState.Ended :
            
            if fullScreenSwipeUp &&  originalLocation.y - self.view.frame.minY > minDeltaUpSwipe {
                
                UIView.animateWithDuration(
                    0.2,
                    animations: { [weak self] in
                        guard let strongslef = self else { return }
                        
                        var frame = strongslef.originalFrame
                        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
                        frame.origin.y = statusBarHeight
                        frame.size.height -= statusBarHeight
                        strongslef.view.frame = frame
                        
                        ModalAnimator.transitionBackgroundView(backgroundView, location: strongslef.view.frame.origin)
                        
                    }, completion: { (result) -> Void in
                        
                        UIView.animateWithDuration(
                            0.1,
                            delay: 0.0,
                            options: UIViewAnimationOptions.CurveLinear,
                            animations: { () -> Void in
                                backgroundView.alpha = 0.0
                            },
                            completion: { [weak self] result in
                                guard let strongslef = self else { return }
                              
                                gestureRecognizer.enabled = false
                                strongslef.si_delegate?.navigationControllerDidSpreadToEntire?(strongslef)
                                
                            }
                        )
                    }
                )
                
            } else if dismissControllSwipeDown && self.view.frame.minY - originalLocation.y > minDeltaDownSwipe {
                si_dismissDownSwipeModalView(nil)
            } else {

                UIView.animateWithDuration(
                    0.6,
                    delay: 0.0,
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.1,
                    options: UIViewAnimationOptions.CurveLinear,
                    animations: { [weak self] in
                        guard let strongslef = self else { return }
                        
                        ModalAnimator.transitionBackgroundView(backgroundView, location: strongslef.originalLocation)
                        
                        var frame = strongslef.originalFrame //view.frame
                        frame.origin.y = strongslef.originalLocation.y
                        frame.size.height -= strongslef.originalLocation.y
                        strongslef.view.frame = frame
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
    
    func parentTargetView() -> UIView {
        if let tabBarController = self.tabBarController {
            return tabBarController.parentTargetView()
        }
        
        return navigationController.parentTargetView()
    }
    
    func parentController() -> UIViewController {
        if let tabBarController = self.tabBarController {
            return tabBarController
        }
        
        return navigationController
    }
    
}
