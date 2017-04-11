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

        weak var sourceViewController: UIViewController?
        weak var destinationViewController: UIViewController?
        (sourceViewController, destinationViewController) = bothEndsViewControllers(
            viewController: base.childViewControllers.last,
            childViewControllers: base.childViewControllers)

        sourceViewController?.willMove(toParentViewController: nil)
        base.willMove(toParentViewController: nil)

        sourceViewController?.beginAppearanceTransition(false, animated: true)
        destinationViewController?.beginAppearanceTransition(true, animated: true)

        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: sourceViewController) {
                completion?()

                sourceViewController?.endAppearanceTransition()
                destinationViewController?.endAppearanceTransition()

                sourceViewController?.removeFromParentViewController()
        }

    }

}

extension UITabBarController {
    
    @objc fileprivate func overlayViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        weak var sourceViewController: UIViewController?
        weak var destinationViewController: UIViewController?
        (sourceViewController, destinationViewController) = si.bothEndsViewControllers(
            viewController: childViewControllers.last,
            childViewControllers: childViewControllers)

        si.parentTargetView.isUserInteractionEnabled = false

        sourceViewController?.willMove(toParentViewController: nil)
        willMove(toParentViewController: nil)
        sourceViewController?.beginAppearanceTransition(false, animated: true)
        destinationViewController?.beginAppearanceTransition(true, animated: true)
        
        ModalAnimator.dismiss(
            fromView: si.parentTargetView,
            presentingViewController: sourceViewController) { [weak self] in

                sourceViewController?.endAppearanceTransition()
                destinationViewController?.endAppearanceTransition()

                sourceViewController?.removeFromParentViewController()
                self?.si.parentTargetView.isUserInteractionEnabled = true
        }
        
    }
    
}
