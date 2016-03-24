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
    
    var statusbarBG:UIView = UIView(frame: UIApplication.sharedApplication().statusBarFrame)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        (self.navigationController as! Shari.NavigationController).si_delegate = self
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
        
        let currentNavigationController = self.navigationController as! Shari.NavigationController
        currentNavigationController.parentNavigationController!.si_dismissModalView({ () -> Void in
            print("close via cell")
        })
        
    }
    
    // MARK: - Button Actions
    
    @IBAction func closeButtonDidTap(sender: AnyObject) {
        
        let currentNavigationController = self.navigationController as! Shari.NavigationController
        currentNavigationController.parentNavigationController!.si_dismissModalView({ () -> Void in
            self.statusbarBG.removeFromSuperview()
            
            print("close via button")
        })
    }
    
    // MARK: - Shari.NavigationControllerDelegate
    
    func navigationControllerDidSpreadToEntire(navigationController: UINavigationController) {
        
        self.tableView.scrollEnabled = true
        
        statusbarBG.backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        UIApplication.sharedApplication().keyWindow!.addSubview(statusbarBG)
        
        print("spread to the entire")
        
    }
    
    
}
