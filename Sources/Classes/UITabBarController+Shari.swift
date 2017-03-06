//
//  UITabBarController+Shari.swift
//  Shari
//
//  Created by nakajijapan on 2016/10/19.
//  Copyright © 2016年 CocoaPods. All rights reserved.
//

import UIKit

public extension Shari where Base: UITabBarController {
    
    var parentTargetView: UIView {
        return base.view
    }
    
    func present(_ viewControllerToPresent: UIViewController) {
        
        viewControllerToPresent.beginAppearanceTransition(true, animated: true)
        ModalAnimator.present(toView: viewControllerToPresent.view, fromView: parentTargetView) { [weak self] in
            guard let strongslef = self else { return }
            viewControllerToPresent.endAppearanceTransition()
            viewControllerToPresent.didMove(toParentViewController: strongslef.base)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: base,
            action: #selector(base.overlayViewDidTap(_:))
        )
        let overlayView = ModalAnimator.overlayView(fromView: parentTargetView)
        overlayView!.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        
        let presentingViewController = base.childViewControllers.last
        presentingViewController!.willMove(toParentViewController: nil)
        
        base.willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: presentingViewController) { [weak self] in
                
                completion?()
                self?.base.presentingViewController?.removeFromParentViewController()

        }
        
    }
    
    func dismissUsingDownSwipe(completion: (() -> Void)? = nil) {
        
        let presentingViewController = base.childViewControllers.last
        presentingViewController!.willMove(toParentViewController: nil)
        
        base.willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: base.view.superview ?? parentTargetView,
            presentingViewController: presentingViewController) { [weak self] in

                completion?()
                self?.base.presentingViewController?.removeFromParentViewController()

        }
        
    }
 
}

extension UITabBarController {
    
    @objc fileprivate func overlayViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        let presentingViewController = childViewControllers.last
        presentingViewController!.willMove(toParentViewController: nil)
        
        si.parentTargetView.isUserInteractionEnabled = false
        willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: si.parentTargetView,
            presentingViewController: presentingViewController) { [weak self] in
                
                self?.presentingViewController?.removeFromParentViewController()
                self?.si.parentTargetView.isUserInteractionEnabled = true
                
        }
        
    }
    
}
