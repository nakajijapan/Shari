//
//  UITabBarController+Shari.swift
//  Shari
//
//  Created by nakajijapan on 2016/10/19.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

public extension UITabBarController {
    
    var parentTargetView: UIView {
        return view
    }
    
    func si_presentViewController(toViewController:UIViewController) {
        
        toViewController.beginAppearanceTransition(true, animated: true)
        ModalAnimator.present(toViewController.view, fromView: parentTargetView) { [weak self] in
            guard let strongslef = self else { return }
            toViewController.endAppearanceTransition()
            toViewController.didMoveToParentViewController(strongslef)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UITabBarController.overlayViewDidTap(_:)))
        let overlayView = ModalAnimator.overlayView(parentTargetView)
        overlayView!.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func si_dismissModalView(completion: (() -> Void)?) {
        
        let presentingViewController = childViewControllers.last
        presentingViewController!.willMoveToParentViewController(nil)
        
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            parentTargetView,
            presentingViewController: presentingViewController) { _ in
                
                completion?()
                self.presentingViewController?.removeFromParentViewController()

        }
        
    }
    
    func overlayViewDidTap(gestureRecognizer: UITapGestureRecognizer) {
        
        let presentingViewController = childViewControllers.last
        presentingViewController!.willMoveToParentViewController(nil)
        
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            parentTargetView,
            presentingViewController: presentingViewController) { _ in
                
                self.presentingViewController?.removeFromParentViewController()
        }
        
    }
    
    func si_dismissDownSwipeModalView(completion: (() -> Void)?) {
        
        let presentingViewController = childViewControllers.last
        presentingViewController!.willMoveToParentViewController(nil)
        
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            view.superview ?? parentTargetView,
            presentingViewController: presentingViewController) { _ in

                completion?()
                self.presentingViewController?.removeFromParentViewController()

        }
        
    }
 
}
