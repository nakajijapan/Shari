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
            nc.dismissControllSwipeDown = true
//            nc.fullScreenSwipeUp = false
        }
//        self.tableView.scrollEnabled = false
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
        
        let currentNavigationController = self.navigationController as! Shari.NavigationController
        
        currentNavigationController.parentNavigationController!.si_dismissModalView({ () -> Void in
            print("close via cell")
        })

    }
    
    // MARK: - Button Actions
    
    @IBAction func closeButtonDidTap(sender: AnyObject) {
        
        let currentNavigationController = self.navigationController as! Shari.NavigationController
        currentNavigationController.parentNavigationController!.si_dismissModalView({ () -> Void in
            print("close via button")
        })
    }

    // MARK: - Shari.NavigationControllerDelegate

    func navigationControllerDidSpreadToEntire(navigationController: UINavigationController) {

//        self.tableView.scrollEnabled = true

        print("spread to the entire")

    }

    
}
