//
//  NextModalViewController.swift
//  Shari-Demo
//
//  Created by Daichi Nakajima on 2020/01/16.
//  Copyright © 2020 nakajijapan. All rights reserved.
//

import UIKit
import Shari

public class NextModalViewController: ShariBaseViewController {

    @IBAction func buttonDidTap(button: UIButton) {

        guard let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }

        // Transition Setting
        ShariSettings.shouldTransformScaleDown = false
        ShariSettings.backgroundColorOfOverlayView = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
        ShariSettings.isUsingScreenShotImage = false

        modalNavigationController.parentBaseViewController = self
        modalNavigationController.cornerRadius = 8
        //modalNavigationController.visibleHeight = 200 // Default: UIScreen.main.bounds.height * 0.5
        si.present(modalNavigationController)
    }

}
