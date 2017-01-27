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
        //tabBarController?.tabBar.hidden = true
    }
    
    // MARK: - Button Actions

    @IBAction func buttonDidTap(button: AnyObject) {

        let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as! ShariNavigationController

        //Shari.ShouldTransformScaleDown = false
        //Shari.BackgroundColorOfOverlayView = UIColor.redColor()
        modalNavigationController.parentNavigationController = navigationController
        
        navigationController?.addChildViewController(modalNavigationController)
        navigationController?.si.presentViewController(toViewController: modalNavigationController)

    }
}
