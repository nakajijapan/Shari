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

        let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as! ShariNavigationController

        // Transition Setting
        //ShouldTransformScaleDown = false
        //BackgroundColorOfOverlayView = UIColor.red
        
        modalNavigationController.parentNavigationController = navigationController
        navigationController?.si.present(modalNavigationController)

    }
}
