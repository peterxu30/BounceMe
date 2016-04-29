//
//  GuestEventsTableViewController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/27/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class GuestEventsTableViewController: MultipeerCapableTableViewController {
    
    var detectedGuestEventsCollection: EventsCollection!
    var testEvents: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectedGuestEventsCollection = EventsCollection()
        testEvents = Array<String>()
        testEvents.append("TEST1")
//        self.sendInvite("TESTAPPLICATION")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GuestEventCell", forIndexPath: indexPath) as! UITableViewCell
        let currentEvent1 = testEvents[indexPath.row]
        let currentEvent = detectedGuestEventsCollection.getEventAtIndex(indexPath.row)
        cell.textLabel?.text = currentEvent.eventName
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detectedGuestEventsCollection.count()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func messageReceived(message: NSDictionary) {
        //Only when detecting an event.
        detectedGuestEventsCollection.appendEvent(message)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func sendInvite(invite: NSDictionary) {
        parentTabBarController.sendMessage(invite)
    }

}

//extension GuestEventsTableViewController: EventServiceManagerDelegate {
//    
//    func connectedDevicesChanged(manager: EventServiceManager, connectedDevices: [String]) {
//        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//            print("Connected Devices: \(connectedDevices)")
//            self.sendApplication("testApplication")
//        }
//    }
//    
//    func eventChanged(manager: EventServiceManager, eventString: String) {
//        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
//            switch eventString {
//            case "red":
////                self.changeEvent(...)
//                print(eventString)
//            case "yellow":
////                self.changeEvent(...)
//                print(eventString)
//            default:
//                NSLog("%@", "Unknown event value received: \(eventString)")
//            }
//        }
//    }
//    
//    func messageReceived(manager: EventServiceManager, messageString: String) {
//        print("Message received: \(messageString)")
//        testEvents.append(messageString)
//        print("Message: \(testEvents)")
//    }
//}
