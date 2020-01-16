//
//  Shari.swift
//  Pods
//
//  Created by nakajijapan on 2015/12/24.
//
//

import Foundation

@available(*, unavailable, renamed: "ShariSettings.backgroundColorOfOverlayView")
public var BackgroundColorOfOverlayView: UIColor = { fatalError() }()

@available(*, unavailable, renamed: "ShariSettings.shouldTransformScaleDown")
public var ShouldTransformScaleDown: Bool = { fatalError() }()

public struct ShariSettings {
    public static var shouldTransformScaleDown = true
    public static var backgroundColorOfOverlayView = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    public static var isUsingScreenShotImage = true
}

public protocol ShariCompatible {
    associatedtype CompatibleType

    static var si: Shari<CompatibleType>.Type { get }
    var si: Shari<CompatibleType> { get }
}

public final class Shari<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }

    func bothEndsViewControllers(viewController: UIViewController?, childViewControllers: [UIViewController]) -> (UIViewController?, UIViewController?) {
        guard let visibleViewController = viewController else {
            return (nil, nil)
        }

        weak var sourceViewController = visibleViewController

        guard let index = childViewControllers.firstIndex(of: visibleViewController) else {
            return (sourceViewController, nil)
        }

        weak var destinationViewController = childViewControllers[index - 1]

        return (sourceViewController, destinationViewController)
    }

    func dismiss(completion: (() -> Void)?) {

    }
    func present(_ viewControllerToPresent: UIViewController) {
        print("so")
    }
}

public extension ShariCompatible {

    static var si: Shari<Self>.Type {
        return Shari<Self>.self
    }

    var si: Shari<Self> {
        return Shari(self)
    }
}

extension UINavigationController: ShariCompatible { }
extension UITabBarController: ShariCompatible { }
extension ShariBaseViewController: ShariCompatible { }

open class ShariBaseViewController: UIViewController {}
public extension Shari where Base: ShariBaseViewController {
    var parentTargetView: UIView {
        return base.view
    }

    func present(_ viewControllerToPresent: UIViewController) {
        print("presefds")
//        var visibleHeight: CGFloat?
//        if let shariNavigationController = viewControllerToPresent as? ShariNavigationController {
//            visibleHeight = shariNavigationController.visibleHeight
//        }
//
//        base.addChild(viewControllerToPresent)
//        viewControllerToPresent.beginAppearanceTransition(true, animated: true)
//        ModalAnimator.present(
//            toView: viewControllerToPresent.view,
//            fromView: parentTargetView,
//            visibleHeight: visibleHeight,
//            completion: {
//                viewControllerToPresent.endAppearanceTransition()
//                viewControllerToPresent.didMove(toParent: self.base)
//        })
//
//        let tapGestureRecognizer = UITapGestureRecognizer(
//            target: base,
//            action: #selector(base.overlayViewDidTap(_:))
//        )
//        let overlayView = ModalAnimator.overlayView(fromView: parentTargetView)
//        overlayView!.addGestureRecognizer(tapGestureRecognizer)
    }

    func dismiss(completion: (() -> Void)? = nil) {

//        weak var sourceViewController: UIViewController?
//        weak var destinationViewController: UIViewController?
//        (sourceViewController, destinationViewController) = bothEndsViewControllers(
//            viewController: base.visibleViewController,
//            childViewControllers: base.children
//        )
//
//        sourceViewController?.willMove(toParent: nil)
//        base.willMove(toParent: nil)
//
//        sourceViewController?.beginAppearanceTransition(false, animated: true)
//        destinationViewController?.beginAppearanceTransition(true, animated: true)
//
//        ModalAnimator.dismiss(
//            fromView: parentTargetView,
//            presentingViewController: base.visibleViewController) {
//                completion?()
//
//                sourceViewController?.endAppearanceTransition()
//                destinationViewController?.endAppearanceTransition()
//
//                sourceViewController?.removeFromParent()
//        }
    }
}
extension ShariBaseViewController {

    @objc fileprivate func overlayViewDidTap(_ gestureRecognizer: UITapGestureRecognizer) {

//        weak var sourceViewController: UIViewController?
//        weak var destinationViewController: UIViewController?
//        (sourceViewController, destinationViewController) = si.bothEndsViewControllers(
//            viewController: children.last,
//            childViewControllers: children
//        )
//
//        si.parentTargetView.isUserInteractionEnabled = false
//
//        sourceViewController?.willMove(toParent: nil)
//        willMove(toParent: nil)
//        sourceViewController?.beginAppearanceTransition(false, animated: true)
//        destinationViewController?.beginAppearanceTransition(true, animated: true)
//
//        ModalAnimator.dismiss(
//            fromView: si.parentTargetView,
//            presentingViewController: visibleViewController) { [weak self] in
//
//                sourceViewController?.endAppearanceTransition()
//                destinationViewController?.endAppearanceTransition()
//
//                sourceViewController?.removeFromParent()
//                self?.si.parentTargetView.isUserInteractionEnabled = true
//        }
    }
}
