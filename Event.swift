//
//  Event.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import Foundation

class Event {
    
    var eventName: String!
    var eventDate: NSDate!
    var eventLocation: String!
    var eventDetails: String!
    var hosting: Bool!
    
    init(eventName: String, eventDate: NSDate, eventLocation: String, eventDetails: String, hosting: Bool) {
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventLocation = eventLocation
        self.eventDetails = eventDetails
        self.hosting = hosting
    }
    
}