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

    @IBAction func buttonDidTap(button: AnyObject) {

        guard let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }

        // Transition Setting
        //ShariSettings.shouldTransformScaleDown = false
        //ShariSettings.backgroundColorOfOverlayView = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        //ShariSettings.isUsingScreenShotImage = false
        
        modalNavigationController.parentNavigationController = navigationController
        modalNavigationController.cornerRadius = 8
        navigationController?.si.present(modalNavigationController)
        //navigationController?.si.present(modalNavigationController, height: 100)
    }
}
