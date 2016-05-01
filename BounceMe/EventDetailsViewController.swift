//
//  EventDetailsViewController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/29/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class EventDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var guestListTableView: UITableView!
    @IBOutlet weak var flashEventButton: UIButton!
    @IBOutlet weak var pulseEventButton: UIButton!
    @IBOutlet weak var eventDetailsTextView: UITextView!
    var hostedEventsTVC: HostedEventsTableViewController!
    var event: HostedEvent!
    var guestList: InvitesCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDetailsTextView.text = "Details: \(event.eventDetails)\nDate: \(event.eventDate)\nLocation: \(event.eventLocation)"
        
        self.guestListTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "GuestCell")
        guestListTableView.delegate = self
        guestListTableView.dataSource = self
        
        if let ev = event {
            guestList = ev.guestList
            reloadTableView()
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestList.count()
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("GuestCell", forIndexPath: indexPath)
        let currentInvite = guestList.getInviteAtIndex(indexPath.row)
        cell.textLabel?.text = currentInvite.userName
        cell.detailTextLabel?.text = "Phone: \(currentInvite.userPhoneNumber), Email: \(currentInvite.userEmail)"
        return cell
    }
    
    func reloadTableView() {
        guestListTableView.reloadData()
        guestListTableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    var myTimer = NSTimer()
    @IBAction func pulseButtonPressed(sender: AnyObject) {
        if pulseEventButton.titleLabel?.text == "Pulse" {
            pulseEventButton.tintColor = UIColor.purpleColor()
            pulseEventButton.setTitle("Pulsing", forState: UIControlState.Normal)
            print("Pulsed")
            myTimer = NSTimer.scheduledTimerWithTimeInterval(4.0, target: self, selector: #selector(self.broadcastEvent), userInfo: nil, repeats: true)
        } else {
            pulseEventButton.tintColor = self.view.tintColor
            pulseEventButton.setTitle("Pulse", forState: UIControlState.Normal)
            myTimer.invalidate()
        }
    }

    @IBAction func flashButtonPressed(sender: AnyObject) {
        print("Flashed")
        hostedEventsTVC.broadcastHostedEvent(event)
    }
    
    @objc private func broadcastEvent() {
        hostedEventsTVC.broadcastHostedEvent(event)
    }
    
//    private func backgroundThread(delay: Double = 0.0, background: (() -> Void)? = nil, completion: (() -> Void)? = nil) {
//        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.rawValue), 0)) {
//            if(background != nil){ background!(); }
//            
//            let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
//            dispatch_after(popTime, dispatch_get_main_queue()) {
//                if(completion != nil){ completion!(); }
//            }
//        }
//    }
}
