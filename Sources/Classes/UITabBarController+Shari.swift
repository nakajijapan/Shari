//
//  UITabBarController+Shari.swift
//  Shari
//
//  Created by nakajijapan on 2016/10/19.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

public extension UITabBarController {
    
    public func parentTargetView() -> UIView {
        return view
    }
    
    func si_presentViewController(toViewController:UIViewController) {
        
        toViewController.beginAppearanceTransition(true, animated: true)
        ModalAnimator.present(toViewController.view, fromView: self.parentTargetView()) { [weak self] in
            guard let strongslef = self else { return }
            toViewController.endAppearanceTransition()
            toViewController.didMoveToParentViewController(strongslef)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITabBarController.overlayViewDidTap(_:)))
        let overlayView = ModalAnimator.overlayView(self.parentTargetView())
        overlayView!.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func si_dismissModalView(completion: (() -> Void)?) {
        
        let presentingViewController = childViewControllers.lastObject
        presentingViewController.willMoveToParentViewController(nil)
        
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            parentTargetView(),
            presentingViewController: presentingViewController) { _ in
                
                completion?()
                
        }
        
    }
    
    func overlayViewDidTap(gestureRecognizer: UITapGestureRecognizer) {
        
        let presentingViewController = childViewControllers.lastObject
        presentingViewController.willMoveToParentViewController(nil)
        
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            parentTargetView(),
            presentingViewController: presentingViewController) { _ in
                
                
        }
        
    }
    
    func si_dismissDownSwipeModalView(completion: (() -> Void)?) {
        
        self.willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            view.superview ?? parentTargetView(),
            presentingViewController: visibleViewController) { _ in
                completion?()
        }
        
    }
 
}
