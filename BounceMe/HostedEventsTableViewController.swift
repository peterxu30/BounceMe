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
    
    @IBOutlet weak var deleteHostedEventUIButton: UIBarButtonItem!
    var deleteModeOn = false
    
    @IBOutlet weak var AddNewHostedEventUIButton: UIBarButtonItem!
    
    var hostedEventsCollection: EventsCollection!
    
    var tempEvent: HostedEvent!
    
    //testing
    @IBAction func testFunction(sender: AnyObject) {
        broadcastHostedEvent(tempEvent)
    }
    
    func reloadData() {
        tableView.reloadData()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    override func viewWillAppear(animated: Bool) {
        reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hostedEventsCollection = EventsCollection()
        
        //testing
        tempEvent = HostedEvent(eventName: "TestEvent", eventDate: NSDate(), eventLocation: "Home", eventDetails: "None", password: "", signInOnce: true)
        hostedEventsCollection.appendEvent(tempEvent)
        print(hostedEventsCollection.count())
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
        
        if deleteModeOn {
            hostedEventsCollection.removeEventAtIndex(indexPath.row)
            reloadData()
        } else {
            self.performSegueWithIdentifier("segueToEventDetails", sender: self)
        }
        
    }
    
//    private func resetCell(cell: HostedEventTableViewCell) {
//        cell.event = nil
//        cell.textLabel?.text = ""
//        cell.detailTextLabel?.text = ""
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "segueToEventDetails" {
            let destinationVC = segue.destinationViewController as! EventDetailsViewController
            let selectedCellIndex = self.tableView.indexPathForSelectedRow!
            let selectedEvent = hostedEventsCollection.getEventAtIndex(selectedCellIndex.row) as! HostedEvent
            destinationVC.hostedEventsTVC = self
            destinationVC.event = selectedEvent
            destinationVC.title = selectedEvent.eventName
        } else if (segue.identifier == "segueToAddNewHostedEvent") {
            print("new event")
            let navVC = segue.destinationViewController as! UINavigationController
            let newEventVC = navVC.viewControllers.first as! AddNewHostedEventViewController
            newEventVC.hostedEventsCollection = hostedEventsCollection
        }
    }
    
    override func messageReceived(message: NSDictionary, sender: MCPeerID) {
        // Only for receiving guest applications
        print("Invite recieved: \(message)")
        let correspondingEvent = hostedEventsCollection.getEventByEventID(message["eventID"] as! String) as! HostedEvent
        correspondingEvent.guestList.appendInvite(message)
        print(correspondingEvent.guestList.count())
        reloadData()
    }
    
    func broadcastHostedEvent(hostedEvent: Event) {
        parentTabBarController.sendMessage(hostedEvent.convertTOSendableObject(parentTabBarController.userProfile.getUserMCPeerID(), recipient: nil))
    }
    
    @IBAction func unwindToToDoListTableViewController(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func deleteHostedEventButtonPressed(sender: AnyObject) {
        if deleteModeOn {
            deleteHostedEventUIButton.tintColor = self.view.tintColor
        } else {
            deleteHostedEventUIButton.tintColor = UIColor.redColor()
        }
        deleteModeOn = !deleteModeOn
    }
}

