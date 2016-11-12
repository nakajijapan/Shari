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
        ModalAnimator.present(toView: toViewController.view, fromView: parentTargetView) { [weak self] in
            guard let strongslef = self else { return }
            toViewController.endAppearanceTransition()
            toViewController.didMove(toParentViewController: strongslef)
            
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UINavigationController.overlayViewDidTap(gestureRecognizer:)))
        let overlayView = ModalAnimator.overlayView(fromView: parentTargetView)
        overlayView!.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func si_dismissModalView(completion: (() -> Void)?) {
        
        willMove(toParentViewController: nil)

        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: visibleViewController) { _ in

                completion?()
                self.visibleViewController?.removeFromParentViewController()
        }
        
    }
    
    func overlayViewDidTap(gestureRecognizer: UITapGestureRecognizer) {
        
        
        parentTargetView.isUserInteractionEnabled = false
        willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: visibleViewController) { _ in
                
                self.visibleViewController?.removeFromParentViewController()
                self.parentTargetView.isUserInteractionEnabled = true

        }

    }
    
    func si_dismissDownSwipeModalView(completion: (() -> Void)?) {
        
        willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: view.superview ?? parentTargetView,
            presentingViewController: visibleViewController) { _ in
                
                completion?()
                self.visibleViewController?.removeFromParentViewController()
                
        }
        
    }
}
