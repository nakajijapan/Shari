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

        var visibleHeight: CGFloat?
        if let shariNavigationController = viewControllerToPresent as? ShariNavigationController {
            visibleHeight = shariNavigationController.visibleHeight
        }

        base.addChild(viewControllerToPresent)
        viewControllerToPresent.beginAppearanceTransition(true, animated: true)

        ModalAnimator.present(
            toView: viewControllerToPresent.view,
            fromView: parentTargetView,
            visibleHeight: visibleHeight,
            completion: {
                viewControllerToPresent.endAppearanceTransition()
                viewControllerToPresent.didMove(toParent: self.base)
        })

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
            viewController: base.children.last,
            childViewControllers: base.children
        )

        sourceViewController?.willMove(toParent: nil)
        base.willMove(toParent: nil)

        sourceViewController?.beginAppearanceTransition(false, animated: true)
        destinationViewController?.beginAppearanceTransition(true, animated: true)

        ModalAnimator.dismiss(
            fromView: parentTargetView,
            presentingViewController: sourceViewController) {
                completion?()

                sourceViewController?.endAppearanceTransition()
                destinationViewController?.endAppearanceTransition()

                sourceViewController?.removeFromParent()
        }
    }
}

extension UITabBarController {
    
    @objc fileprivate func overlayViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {
        
        weak var sourceViewController: UIViewController?
        weak var destinationViewController: UIViewController?
        (sourceViewController, destinationViewController) = si.bothEndsViewControllers(
            viewController: children.last,
            childViewControllers: children
        )

        si.parentTargetView.isUserInteractionEnabled = false

        sourceViewController?.willMove(toParent: nil)
        willMove(toParent: nil)
        sourceViewController?.beginAppearanceTransition(false, animated: true)
        destinationViewController?.beginAppearanceTransition(true, animated: true)
        
        ModalAnimator.dismiss(
            fromView: si.parentTargetView,
            presentingViewController: sourceViewController) { [weak self] in

                sourceViewController?.endAppearanceTransition()
                destinationViewController?.endAppearanceTransition()

                sourceViewController?.removeFromParent()
                self?.si.parentTargetView.isUserInteractionEnabled = true
        }
    }
}
