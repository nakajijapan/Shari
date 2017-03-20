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

public extension Shari where Base: UINavigationController {

    var parentTargetView: UIView {
        return base.view
    }
    
    func present(_ viewControllerToPresent: UIViewController) {

        base.addChildViewController(viewControllerToPresent)
        viewControllerToPresent.beginAppearanceTransition(true, animated: true)
        ModalAnimator.present(toView: viewControllerToPresent.view, fromView: parentTargetView) { [weak self] in
            guard let strongSelf = self else { return }
            viewControllerToPresent.endAppearanceTransition()
            viewControllerToPresent.didMove(toParentViewController: strongSelf.base)
        }
        
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: base,
            action: #selector(base.overlayViewDidTap(_:))
        )
        let overlayView = ModalAnimator.overlayView(fromView: parentTargetView)
        overlayView!.addGestureRecognizer(tapGestureRecognizer)

    }
    
    func dismiss(completion: (() -> Void)? = nil) {
        
        guard let visibleViewController = base.visibleViewController,
            let index = base.childViewControllers.index(of: visibleViewController) else {
                return
        }
        
        let distinationViewController = base.childViewControllers[index - 1]
        distinationViewController.beginAppearanceTransition(true, animated: true)
        
        base.willMove(toParentViewController: nil)
       
        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: base.visibleViewController) {
                completion?()
                visibleViewController.removeFromParentViewController()
                distinationViewController.endAppearanceTransition()
        }
        
    }
    
    func dismissUsingDownSwipe(completion: (() -> Void)? = nil) {

        guard let visibleViewController = base.visibleViewController,
            let index = base.childViewControllers.index(of: visibleViewController) else {
                return
        }
        
        let distinationViewController = base.childViewControllers[index - 1]
        distinationViewController.beginAppearanceTransition(true, animated: true)
        
        base.willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: base.view.superview ?? parentTargetView,
            presentingViewController: base.visibleViewController) {
                completion?()
                visibleViewController.removeFromParentViewController()
                distinationViewController.endAppearanceTransition()
        }
        
    }
}

extension UINavigationController {
    
    @objc fileprivate func overlayViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        si.parentTargetView.isUserInteractionEnabled = false
        willMove(toParentViewController: nil)
        
        ModalAnimator.dismiss(
            fromView: si.parentTargetView,
            presentingViewController: visibleViewController) { [weak self] in
                
                self?.visibleViewController?.removeFromParentViewController()
                self?.si.parentTargetView.isUserInteractionEnabled = true
                
        }
        
    }
}

