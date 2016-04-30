//
//  HostedEventsTableViewController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class HostedEventsTableViewController: MultipeerCapableTableViewController {
    
    @IBOutlet weak var AddNewHostedEventUIButton: UIBarButtonItem!
//    @IBOutlet weak var connectionsLabel: UILabel!
    var hostedEventsCollection: EventsCollection!
    
    var tempEvent: HostedEvent!
    
    //testing
    @IBAction func testFunction(sender: AnyObject) {
        broadcastHostedEvent(tempEvent)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hostedEventsCollection = EventsCollection()
        
        //testing
        tempEvent = HostedEvent(eventName: "TestEvent", eventDate: NSDate(), eventLocation: "Home", eventDetails: "None", password: "", signInOnce: true)
        hostedEventsCollection.appendEvent(tempEvent)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HostEventCell", forIndexPath: indexPath) as! HostedEventTableViewCell
        let currentEvent = hostedEventsCollection.getEventAtIndex(indexPath.row) as! HostedEvent
        cell.event = currentEvent
        cell.textLabel?.text = currentEvent.eventName
        cell.detailTextLabel?.text = "Number checked in: \(currentEvent.guestList.count())"
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostedEventsCollection.count()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("segueToEventDetails", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToEventDetails" {
            let destinationVC = segue.destinationViewController as! EventDetailsViewController
            let selectedCellIndex = self.tableView.indexPathForSelectedRow!
            let selectedEvent = hostedEventsCollection.getEventAtIndex(selectedCellIndex.row) as! HostedEvent
            destinationVC.hostedEventsTVC = self
            destinationVC.event = selectedEvent
            destinationVC.title = selectedEvent.eventName
        }
    }
    
//    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) {
//        self.performSegueWithIdentifier("segueToEventDetails", sender: self)
//    }
    
    override func messageReceived(message: NSDictionary) {
        // Only for receiving guest applications
        hostedEventsCollection.appendEvent(message)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func broadcastHostedEvent(hostedEvent: Event) {
        parentTabBarController.sendMessage(hostedEvent.convertTOSendableObject(parentTabBarController.userProfile.getUserMCPeerID(), recipient: nil))
    }
    
}

