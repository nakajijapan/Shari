//
//  ModalTableViewController.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/07.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit
import Shari

class ModalTableViewController: UITableViewController, ShariNavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nc = navigationController as? ShariNavigationController {
            nc.si_delegate = self
            nc.fullScreenSwipeUp = true
            nc.dismissControllSwipeDown = false
        }
        tableView.isScrollEnabled = false
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "Title #\(indexPath.row)"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let currentController = navigationController as! ShariNavigationController
        let completion = {
            print("close via cell")
        }
        
        if let parentController = currentController.parentNavigationController {
            parentController.si.dismiss(completion: completion)
        } else if let parentController = currentController.parentTabBarController {
            parentController.si.dismiss(completion: completion)
        }

    }
    
    // MARK: - Button Actions
    
    @IBAction func closeButtonDidTap(button: UIBarButtonItem) {
        
        let currentController = navigationController as! ShariNavigationController
        let completion = {
            print("close via button")
        }

        if let parentController = currentController.parentNavigationController {
            parentController.si.dismiss(completion: completion)
        } else if let parentController = currentController.parentTabBarController {
            parentController.si.dismiss(completion: completion)
        }
    }

    // MARK: - Shari.NavigationControllerDelegate

    func navigationControllerDidSpreadToEntire(navigationController: UINavigationController) {

        tableView.isScrollEnabled = true

        print("spread to the entire")

    }

    
}
