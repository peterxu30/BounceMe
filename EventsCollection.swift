//
//  HostedEventsCollection.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class EventsCollection {
    
    let eventsCalendar = NSCalendar.currentCalendar()
    
    struct Event {
        var eventName: String
        var eventDate: NSDate
        var eventLocation: String
        var eventDetails: String
        var hosting: Bool
        var password: String
    }
    
    private var eventsList = Array<Event>()
    
    func loadGuestEvents() {
        
    }
    
    
    
}
