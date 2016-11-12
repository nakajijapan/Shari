//
//  UINavigationController+Shari.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/11.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit

enum InternalStructureViewType:Int {
    case ToView = 900, ScreenShot = 910, Overlay = 920
}

public extension UINavigationController {

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
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UINavigationController.overlayViewDidTap(_:)))
        let overlayView = ModalAnimator.overlayView(parentTargetView)
        overlayView!.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func si_dismissModalView(completion: (() -> Void)?) {
        
        willMoveToParentViewController(nil)

        ModalAnimator.dismiss(
            parentTargetView,
            presentingViewController: visibleViewController) { _ in

                completion?()
                self.visibleViewController?.removeFromParentViewController()
        }
        
    }
    
    func overlayViewDidTap(gestureRecognizer: UITapGestureRecognizer) {
        
        
        parentTargetView.userInteractionEnabled = false
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            parentTargetView,
            presentingViewController: visibleViewController) { _ in
                
                self.visibleViewController?.removeFromParentViewController()
                self.parentTargetView.userInteractionEnabled = true

        }

    }
    
    func si_dismissDownSwipeModalView(completion: (() -> Void)?) {
        
        willMoveToParentViewController(nil)
        
        ModalAnimator.dismiss(
            view.superview ?? parentTargetView,
            presentingViewController: visibleViewController) { _ in
                
                completion?()
                self.visibleViewController?.removeFromParentViewController()
                
        }
        
    }
}
