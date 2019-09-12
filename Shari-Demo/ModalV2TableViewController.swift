//
//  ModalV2TableViewController.swift
//  Shari-Demo
//
//  Created by Daichi Nakajima on 2019/09/11.
//  Copyright © 2019 nakajijapan. All rights reserved.
//

import UIKit
import Shari

class ModalV2TableViewController: UIViewController, ShariNavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if let nc = navigationController as? ShariNavigationController {
            nc.si_delegate = self
            nc.fullScreenSwipeUp = true
            nc.dismissControllSwipeDown = true
            nc.isScrollableOnOverlayView = true
        }
        tableView.isScrollEnabled = false
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let currentController = navigationController as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }
        currentController.transition(height: nil)
        
        let lineView = LineView()
        lineView.frame = .zero
        lineView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(lineView)
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            lineView.widthAnchor.constraint(equalToConstant: view.bounds.width),
            lineView.heightAnchor.constraint(equalToConstant: 28),
            lineView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        cell.textLabel!.text = "Title #\(indexPath.row)"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currentController = navigationController as? ShariNavigationController else {
            fatalError("Need the ShariNavigationController")
        }
        
        if indexPath.row == 0 {
            let viewController = NextViewController.loadFromStoryboard()
            navigationController?.pushViewController(viewController, animated: true)
        } else {
            let completion = {
                print("close via cell")
            }
            
            if let parentController = currentController.parentNavigationController {
                parentController.si.dismiss(completion: completion)
            } else if let parentController = currentController.parentTabBarController {
                parentController.si.dismiss(completion: completion)
            }
        }
    }
    
    // MARK: - Shari.NavigationControllerDelegate
    
    func navigationControllerDidSpreadToEntire(navigationController: UINavigationController) {
        
        tableView.isScrollEnabled = true
        
        print("spread to the entire")
        
    }
    
}
