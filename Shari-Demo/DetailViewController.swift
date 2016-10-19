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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController.tabBar.setHidden(true)
    }
    
    // MARK: - Button Actions

    @IBAction func buttonDidTap(sender: AnyObject) {

        let modalNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("ModalNavigationController") as! Shari.NavigationController

        //Shari.ShouldTransformScaleDown = false
        //Shari.BackgroundColorOfOverlayView = UIColor.redColor()
        modalNavigationController.parentNavigationController = self.navigationController
        
        self.navigationController!.addChildViewController(modalNavigationController)
        self.navigationController?.si_presentViewController(modalNavigationController)

    }
}
