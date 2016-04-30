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
    
    var detectedGuestEventsCollection = EventsCollection()
    var testEvents: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testEvents = Array<String>()
//        testEvents.append("TEST1")
//        self.sendInvite("TESTAPPLICATION")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GuestEventCell", forIndexPath: indexPath) as! UITableViewCell
//        let currentEvent1 = testEvents[indexPath.row]
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
        reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func sendInvite(invite: Invite, event: MCPeerID) {
        parentTabBarController.sendMessage(invite.convertTOSendableObject(parentTabBarController.userProfile.getUserMCPeerID(), recipient: event))
    }

}
