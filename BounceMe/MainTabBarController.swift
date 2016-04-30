//
//  MainTabBarController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

protocol MainTabBarControllerCommunicator {
    
    func messageReceived(message: NSDictionary)
    
}

class MainTabBarController: UITabBarController {
    
    var userProfile: UserProfile!
    var defaults = NSUserDefaults.standardUserDefaults()
    var activeTab = ""
    var activeViewController: MultipeerCapableTableViewController!
    var eventService: EventServiceManager!
    var hostedEventTableViewController: MultipeerCapableTableViewController!
    var guestEventTableViewController: MultipeerCapableTableViewController!
    
    override func viewDidLoad() {
        print("TabView loaded")
        userProfile = loadExistingUserProfile()
        eventService = EventServiceManager(peerID: userProfile.getUserMCPeerID())
        eventService.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        let uiNavController = self.selectedViewController as! UINavigationController
        
        let views = self.viewControllers!
        for index in 0..<views.count {
            let navView = views[index] as! UINavigationController
            if index == 0 {
                print("I'm the host")
                
                hostedEventTableViewController = navView.visibleViewController as! MultipeerCapableTableViewController
            } else if index == 1 {
                print("I'm the guest")
                guestEventTableViewController = navView.visibleViewController as! MultipeerCapableTableViewController
            }
        }
        
        activeViewController = uiNavController.visibleViewController as! MultipeerCapableTableViewController
        activeTab = activeViewController.tabBarItem.title!
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        let uiNavController = self.selectedViewController as! UINavigationController
        if (activeTab != "Profile") {
            activeViewController = uiNavController.visibleViewController as! MultipeerCapableTableViewController
        } else {
            activeViewController = nil
        }
        activeTab = item.title!
    }
    
    func loadExistingUserProfile() -> UserProfile {
        if let userProfileNSData = defaults.objectForKey("userProfile") as? NSData {
            print("exists")
            let userProfileUnarchived = NSKeyedUnarchiver(forReadingWithData: userProfileNSData)
            userProfile = userProfileUnarchived.decodeObjectForKey("root") as! UserProfile
            print(userProfile.getUserMCPeerID())
        } else {
            userProfile = UserProfile()
            defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(userProfile), forKey: "userProfile")
        }
        return userProfile
    }
    
    func sendMessage(message: NSDictionary) {
        eventService.sendMessage(message)
    }
    
}

extension MainTabBarController: EventServiceManagerDelegate {
    func connectedDevicesChanged(manager: EventServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            print("Connected Devices: \(connectedDevices)")
        }
    }
    
    func messageReceived(manager: EventServiceManager, message: NSDictionary) {
        print("Message received: \(message)")
        if (activeTab != "Profile") {
            if message["type"] as! String == "Event" {
                print("Routed to guest")
                guestEventTableViewController.messageReceived(message)
            } else if message["type"] as! String == "Invite" {
                print("Routed to host")
                hostedEventTableViewController.messageReceived(message)
            }
//            activeViewController.messageReceived(message)
        }
    }
}
