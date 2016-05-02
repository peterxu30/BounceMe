//
//  AddNewHostedEventViewController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/30/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class AddNewHostedEventViewController: UIViewController {
    
    @IBOutlet weak var cancelEventButton: UIBarButtonItem!
    @IBOutlet weak var saveEventButton: UIBarButtonItem!
    @IBOutlet weak var newEventSingleSignInSwitch: UISwitch!
    @IBOutlet weak var newEventLocationTextField: UITextField!
    @IBOutlet weak var newEventDateTextField: UITextField!
    @IBOutlet weak var newEventDetailsTextField: UITextField!
    @IBOutlet weak var newEventNameTextField: UITextField!
    
    var hostedEventsCollection: EventsCollection!
    
    func saveEvent() {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let date = NSDate()//formatter.dateFromString(newEventDateTextField.text!)
        print(date)
        let newHostedEvent = HostedEvent(eventName: newEventNameTextField.text!, eventDate: date, eventLocation: newEventLocationTextField.text!, eventDetails: newEventDetailsTextField.text!, password: "", signInOnce: newEventSingleSignInSwitch.on)
        if (newHostedEvent.eventName != "") {
           hostedEventsCollection.appendEvent(newHostedEvent)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let button = sender as! UIBarButtonItem
        if button == saveEventButton {
            saveEvent()
        }
        let destinationVC = segue.destinationViewController as! HostedEventsTableViewController
        destinationVC.hostedEventsCollection = hostedEventsCollection
        print(hostedEventsCollection.count())
    }
}
