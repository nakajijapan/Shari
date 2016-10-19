//
//  ModalTableViewController.swift
//  Shari
//
//  Created by nakajijapan on 2015/12/07.
//  Copyright © 2015 nakajijapan. All rights reserved.
//

import UIKit
import Shari

class ModalTableViewController: UITableViewController, Shari.NavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nc = self.navigationController as? Shari.NavigationController {
            nc.si_delegate = self
            nc.fullScreenSwipeUp = true
            nc.dismissControllSwipeDown = false
        }
        self.tableView.scrollEnabled = false
    }
    
    // MARK: - UITableViewDataSource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        cell.textLabel!.text = "Title #\(indexPath.row)"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let currentController = self.navigationController as! Shari.NavigationController
        let completion = {() -> Void in
            print("close via cell")
        }
        
        if let parentController = currentController.parentNavigationController {
            parentController.si_dismissModalView(completion)
        } else if let parentController = currentController.parentTabBarController {
            parentController.si_dismissModalView(completion)
        }

    }
    
    // MARK: - Button Actions
    
    @IBAction func closeButtonDidTap(sender: AnyObject) {
        
        let currentController = self.navigationController as! Shari.NavigationController
        let completion = {() -> Void in
            print("close via button")
        }

        if let parentController = currentController.parentNavigationController {
            parentController.si_dismissModalView(completion)
        } else if let parentController = currentController.parentTabBarController {
            parentController.si_dismissModalView(completion)
        }
    }

    // MARK: - Shari.NavigationControllerDelegate

    func navigationControllerDidSpreadToEntire(navigationController: UINavigationController) {

        self.tableView.scrollEnabled = true

        print("spread to the entire")

    }

    
}
