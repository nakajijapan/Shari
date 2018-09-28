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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func buttonDidTap(button: UIButton) {
        
        guard let modalNavigationController = storyboard!.instantiateViewController(withIdentifier: "ModalNavigationController") as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }
        
        // Transition Setting
        //ShariSettings.shouldTransformScaleDown = false
        //ShariSettings.backgroundColorOfOverlayView = UIColor.red

        modalNavigationController.parentTabBarController = tabBarController
        modalNavigationController.cornerRadius = 8
        tabBarController?.si.present(modalNavigationController)
    }
}
