//
//  NextViewController.swift
//  Shari-Demo
//
//  Created by Daichi Nakajima on 2019/02/15.
//  Copyright © 2019 nakajijapan. All rights reserved.
//

import UIKit
import Shari

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let currentController = navigationController as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            currentController.transition(height: 250)
        }
    }

}
