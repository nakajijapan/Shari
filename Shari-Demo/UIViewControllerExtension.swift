//
//  UIViewControllerExtension.swift
//  Shari-Demo
//
//  Created by Daichi Nakajima on 2019/02/15.
//  Copyright © 2019 nakajijapan. All rights reserved.
//

import UIKit

protocol StoryboardInitializable {}

extension StoryboardInitializable where Self: UIViewController {

    static func loadFromStoryboard() -> Self {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        guard let viewController = storyboard.instantiateInitialViewController() as? Self else {
            fatalError("Can not load ViewController")
        }
        return viewController
    }
}

extension UIViewController: StoryboardInitializable {}
