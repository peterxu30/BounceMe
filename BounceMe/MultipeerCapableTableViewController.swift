//
//  MultipeerCapableTableViewController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/28/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class MultipeerCapableTableViewController: UITableViewController {
    
    var parentTabBarController: MainTabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        parentTabBarController = self.tabBarController! as! MainTabBarController
    }
    
}

extension MultipeerCapableTableViewController: MainTabBarControllerCommunicator {
    
    func messageReceived(message: NSDictionary) {
        //override me
    }
    
}
