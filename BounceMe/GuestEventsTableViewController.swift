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
    var eventSenders = Dictionary<String, MCPeerID>()
    var testEvents: Array<String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        testEvents = Array<String>()
//        testEvents.append("TEST1")
//        self.sendInvite("TESTAPPLICATION")
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GuestEventCell", forIndexPath: indexPath) as! GuestEventTableViewCell

        let currentEvent = detectedGuestEventsCollection.getEventAtIndex(indexPath.row)
        cell.textLabel?.text = currentEvent.eventName
        cell.event = currentEvent
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detectedGuestEventsCollection.count()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! GuestEventTableViewCell
        let cellID = cell.event?.eventID
        
        let sendInviteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Send Invite" , handler: { (action:UITableViewRowAction!, indexPath:NSIndexPath!) -> Void in
            
            let eventTarget = self.eventSenders[cellID!]!
            self.sendInvite(Invite(profile: self.parentTabBarController.userProfile, id: cellID!), event: eventTarget)
            cell.accessoryType = .Checkmark
//            cell.accessoryType = .Checkmark
//            self.toDoList.markToDoItemAsCompleted(cell.toDoItem)
        })
        sendInviteAction.backgroundColor = self.view.tintColor
        return [sendInviteAction]
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        
////        if deleteModeOn {
////            hostedEventsCollection.removeEventAtIndex(indexPath.row)
////            reloadData()
////        } else {
////            self.performSegueWithIdentifier("segueToEventDetails", sender: self)
////        }
//        
//    }
    
    override func messageReceived(message: NSDictionary, sender: MCPeerID) {
        //Only when detecting an event.
        detectedGuestEventsCollection.appendEvent(message)
        eventSenders[message["eventID"] as! String] = sender
        reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func sendInvite(invite: Invite, event: MCPeerID) {
        print("invite sent")
        parentTabBarController.sendMessage(invite.convertTOSendableObject(parentTabBarController.userProfile.getUserMCPeerID(), recipient: event))
    }

}
