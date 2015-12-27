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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Button Actions

    @IBAction func buttonDidTap(sender: AnyObject) {

        let modalNavigationVC = self.storyboard!.instantiateViewControllerWithIdentifier("ModalNavigationController") as! Shari.NavigationController

        //Shari.BackgroundColorOfOverlayView = UIColor.redColor()
        modalNavigationVC.parentNavigationController = self.navigationController
        
        self.navigationController!.addChildViewController(modalNavigationVC)
        self.navigationController?.si_presentViewController(modalNavigationVC)

    }
}
