//
//  DetailViewController.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/07.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit
import Shari

class DetailViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Button Actions

    @IBAction func buttonDidTap(button: UIButton) {

        guard let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }

        // Transition Setting
        ShariSettings.shouldTransformScaleDown = false
        ShariSettings.backgroundColorOfOverlayView = UIColor(red: 1, green: 0, blue: 0, alpha: 0.6)
        ShariSettings.isUsingScreenShotImage = false

        modalNavigationController.parentNavigationController = navigationController
        modalNavigationController.cornerRadius = 8
        //modalNavigationController.visibleHeight = 200 // Default: UIScreen.main.bounds.height * 0.5
        navigationController?.si.present(modalNavigationController)
    }

    @IBAction func button2DidTap(button: UIButton) {
        guard let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalV2NavigationController") as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }

        // Transition Setting
        ShariSettings.shouldTransformScaleDown = false
        ShariSettings.backgroundColorOfOverlayView = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        ShariSettings.isUsingScreenShotImage = false

        modalNavigationController.parentNavigationController = navigationController
        modalNavigationController.cornerRadius = 8
        navigationController?.si.present(modalNavigationController)
    }
}
