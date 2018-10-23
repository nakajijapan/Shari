//
//  NavigationController.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/14.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit

@objc public protocol ShariNavigationControllerDelegate {
    @objc optional func navigationControllerDidSpreadToEntire(navigationController: UINavigationController)
}

public class ShariNavigationController: UINavigationController {

    public weak var si_delegate: ShariNavigationControllerDelegate?
    public var parentNavigationController: UINavigationController?
    public var parentTabBarController: UITabBarController?
    
    public var minDeltaUpSwipe: CGFloat = 50.0
    public var minDeltaDownSwipe: CGFloat = 100.0
    
    public var dismissControllSwipeDown = false
    public var fullScreenSwipeUp = true
    public var cornerRadius: CGFloat = 0
    public var visibleHeight: CGFloat?

    private var previousLocation = CGPoint.zero
    private var originalLocation = CGPoint.zero
    private var isRotating = false

    override public func viewDidLoad() {

        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(self.handlePanGesture(_:))
        )
        view.addGestureRecognizer(panGestureRecognizer)

        if cornerRadius > 0 {
            view.layer.cornerRadius = cornerRadius
            view.clipsToBounds = true
            ModalAnimator.cornerRadius = cornerRadius
        }

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.orientationDidChanged(_:)),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func orientationDidChanged(_ notification: NSNotification) {
        isRotating = false

    }

    public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        isRotating = true
    }

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let overlayView = ModalAnimator.overlayView(fromView: parentTargetView) else { return }
        overlayView.frame = parentTargetView.bounds

        if isRotating {
            view.frame = ModalAnimator.visibleFrameForContainerView(
                fromView: overlayView,
                visibleHeight: visibleHeight
            )
        }
    }

    private func animateMoveToTopPosition(gestureRecognizer: UIPanGestureRecognizer, backgroundView: UIView) {
        UIView.animate(
            withDuration: 0.2,
            animations: { [weak self] in
                guard let strongslef = self else {
                    return
                }

                var frame = backgroundView.frame
                let statusBarHeight = UIApplication.shared.statusBarFrame.height
                frame.origin.y = statusBarHeight
                frame.size.height -= statusBarHeight
                strongslef.view.frame = frame

                ModalAnimator.transitionBackgroundView(overlayView: backgroundView, location: strongslef.view.frame.origin)
            },
            completion: { _ -> Void in
                UIView.animate(
                    withDuration: 0.1,
                    delay: 0.0,
                    options: .curveLinear,
                    animations: {
                        backgroundView.alpha = 0.0
                    },
                    completion: { [weak self] _ in
                        guard let strongslef = self else { return }
                        gestureRecognizer.isEnabled = false
                        strongslef.si_delegate?.navigationControllerDidSpreadToEntire?(navigationController: strongslef)
                    }
                )
        })
    }

    private func animateBackToBeginPosition(gestureRecognizer: UIPanGestureRecognizer, backgroundView: UIView) {
        UIView.animate(
            withDuration: 0.6,
            delay: 0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.1,
            options: .curveLinear,
            animations: { [weak self] in
                guard let strongslef = self else { return }
                ModalAnimator.transitionBackgroundView(overlayView: backgroundView, location: strongslef.originalLocation)

                var frame = backgroundView.frame
                frame.origin.y = strongslef.originalLocation.y
                frame.size.height -= strongslef.originalLocation.y
                strongslef.view.frame = frame
            },

            completion: { _ in
                gestureRecognizer.isEnabled = true
        })
    }

    @objc private func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        let location = gestureRecognizer.location(in: parent!.view)
        let backgroundView = ModalAnimator.overlayView(fromView: parentTargetView)!
        let degreeY = location.y - previousLocation.y

        switch gestureRecognizer.state {
        case .began:
            originalLocation = view.frame.origin
        case .changed:
            var frame = view.frame
            frame.origin.y += degreeY
            frame.size.height += -degreeY
            view.frame = frame

            ModalAnimator.transitionBackgroundView(overlayView: backgroundView, location: location)
        case .ended :
            if fullScreenSwipeUp &&  originalLocation.y - view.frame.minY > minDeltaUpSwipe {
                animateMoveToTopPosition(gestureRecognizer: gestureRecognizer, backgroundView: backgroundView)
            } else if dismissControllSwipeDown && view.frame.minY - originalLocation.y > minDeltaDownSwipe {
                if let controller = parentTabBarController {
                    controller.si.dismiss()
                } else if let controller = parentNavigationController {
                    controller.si.dismiss()
                }
            } else {
                animateBackToBeginPosition(gestureRecognizer: gestureRecognizer, backgroundView: backgroundView)
            }
        default:
            break
        }
        
        previousLocation = location
        
    }
    
    public var parentTargetView: UIView {
        if tabBarController != nil {
            return tabBarController!.si.parentTargetView
        }
        
        return navigationController!.si.parentTargetView
    }
    
    public var parentController: UIViewController {
        if let tabBarController = tabBarController {
            return tabBarController
        }
        
        return navigationController!
    }
    
}
