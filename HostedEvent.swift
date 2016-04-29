//
//  HostedEvent.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import Foundation

class HostedEvent: Event {
    
    var password: String!
    
    init(eventName: String, eventDate: NSDate, eventLocation: String, eventDetails: String, password: String, signInOnce: Bool) {
        super.init(eventName: eventName, eventDate: eventDate, eventLocation: eventLocation, eventDetails: eventDetails, hosting: true, signInOnce: signInOnce)
        self.password = password
    }
    
}