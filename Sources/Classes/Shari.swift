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
    
    func bothEndsViewControllers(viewController: UIViewController?, childViewControllers: [UIViewController]) -> (UIViewController?, UIViewController?) {
        
        guard let visibleViewController = viewController else {
            return (nil, nil)
        }
        
        weak var sourceViewController = visibleViewController
        
        guard let index = childViewControllers.index(of: visibleViewController) else {
            return (sourceViewController, nil)
        }
        
        weak var destinationViewController = childViewControllers[index - 1]
        
        return (sourceViewController, destinationViewController)
    }
}

public extension ShariCompatible {
    public var si: Shari<Self> {
        get {
            return Shari(self)
        }
    }
}

extension UINavigationController: ShariCompatible { }
extension UITabBarController: ShariCompatible { }
