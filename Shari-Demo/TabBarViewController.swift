//
//  TabBarViewController.swift
//  Shari-Demo
//
//  Created by nakajijapan on 2016/10/19.
//  Copyright © 2016年 nakajijapan. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {

    @IBAction func buttonDidTap(sender: AnyObject) {
        
        let modalNavigationController = self.storyboard!.instantiateViewControllerWithIdentifier("ModalNavigationController") as! Shari.NavigationController
        
        //Shari.ShouldTransformScaleDown = false
        //Shari.BackgroundColorOfOverlayView = UIColor.redColor()
        modalNavigationController.parentNavigationController = self.tabBarController
        
        self.navigationController!.addChildViewController(modalNavigationController)
        self.navigationController?.si_presentViewController(modalNavigationController)
        
    }
}
