//
//  TabBarViewController.swift
//  Shari-Demo
//
//  Created by nakajijapan on 2016/10/19.
//  Copyright © 2016年 nakajijapan. All rights reserved.
//

import UIKit
import Shari

class TabBarViewController: UIViewController {

    @IBAction func buttonDidTap(button: UIButton) {
        
        let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as! Shari.NavigationController
        
        //Shari.ShouldTransformScaleDown = false
        //Shari.BackgroundColorOfOverlayView = UIColor.redColor()
        modalNavigationController.parentTabBarController = tabBarController
        
        tabBarController?.addChildViewController(modalNavigationController)
        tabBarController?.si_presentViewController(toViewController: modalNavigationController)
        
    }
}
