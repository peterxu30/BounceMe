//
//  HostedEventsTableViewController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class HostedEventsTableViewController: UITableViewController {
    
    @IBOutlet weak var connectionsLabel: UILabel!
    
    let eventService = EventServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventService.delegate = self
    }
    
}

extension HostedEventsTableViewController: EventServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: EventServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock {
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }

}
