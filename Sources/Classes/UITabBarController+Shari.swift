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
        
        base.addChildViewController(viewControllerToPresent)
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

        guard let presentingViewController = base.childViewControllers.last,
            let index = base.childViewControllers.index(of: presentingViewController) else {
                return
        }

        presentingViewController.willMove(toParentViewController: nil)
        base.willMove(toParentViewController: nil)
        let distinationViewController = base.childViewControllers[index - 1]
        distinationViewController.beginAppearanceTransition(true, animated: true)

        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: presentingViewController) {
                completion?()
                presentingViewController.removeFromParentViewController()
                distinationViewController.endAppearanceTransition()
        }
        
    }

 
}

extension UITabBarController {
    
    @objc fileprivate func overlayViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {
      
        guard let presentingViewController = childViewControllers.last,
            let index = childViewControllers.index(of: presentingViewController) else {
                return
        }

        si.parentTargetView.isUserInteractionEnabled = false

        presentingViewController.willMove(toParentViewController: nil)
        willMove(toParentViewController: nil)
        let distinationViewController = childViewControllers[index - 1]
        distinationViewController.beginAppearanceTransition(true, animated: true)
        
        ModalAnimator.dismiss(
            fromView: si.parentTargetView,
            presentingViewController: presentingViewController) { [weak self] in
                presentingViewController.removeFromParentViewController()
                distinationViewController.endAppearanceTransition()
                self?.si.parentTargetView.isUserInteractionEnabled = true
        }
        
    }
    
}
