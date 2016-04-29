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
    
    @IBAction func testFunction(sender: AnyObject) {
        broadcastHostedEvent(Event(eventName: "TestEvent", eventDate: NSDate(), eventLocation: "Home", eventDetails: "None", hosting: true, signInOnce: true))
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hostedEventsCollection = EventsCollection()
        
        //testing
        let event = Event(eventName: "TestEvent", eventDate: NSDate(), eventLocation: "Home", eventDetails: "None", hosting: true, signInOnce: true)
        hostedEventsCollection.appendEvent(event)
        let testString = event.toJSON()
        let test = Event(jsonDictionary: testString)
        print(test.eventLocation)
        broadcastHostedEvent(event)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HostEventCell", forIndexPath: indexPath) as! UITableViewCell
        let currentEvent = hostedEventsCollection.getEventAtIndex(indexPath.row)
        cell.textLabel?.text = currentEvent.eventName
        return cell
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hostedEventsCollection.count()
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func messageReceived(message: NSDictionary) {
        // Only for receiving guest applications
        
//        checkIfValidInvite(message)
    }
    
//    func checkIfValidInvite(messageString: String) {
//        let invite = Invite(jsonString: messageString)
//        if (invite.type != "NONE") {
//            
//        }
//    }
    
    func broadcastHostedEvent(hostedEvent: Event) {
        print(hostedEvent.toJSON())
        parentTabBarController.sendMessage(hostedEvent.toJSON())
    }
    
}

