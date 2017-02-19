//
//  Shari.swift
//  Pods
//
//  Created by nakajijapan on 2015/12/24.
//
//

import Foundation

public var BackgroundColorOfOverlayView = UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
public var ShouldTransformScaleDown = true

public protocol ShariCompatible {
    associatedtype CompatibleType
    var si: CompatibleType { get }
}

public final class Shari<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension ShariCompatible {
    public var si: Shari<Self> {
        get {
            return Shari(self)
        }
    }
}

protocol ShariModalizable {
    var parentTargetView: UIView { get }
    func present(modalViewControllerToPresent viewController: UIViewController) -> Void
    func dismiss(modalView completion: (() -> Void)?) -> Void
    func dismiss(modalViewwithDownSwipe completion: (() -> Void)?) -> Void
}

extension UINavigationController: ShariCompatible { }
extension UITabBarController: ShariCompatible { }
