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
    
    private var eventsList = Array<Event>()
    
    func getAllEvents() -> Array<Event> {
        return eventsList
    }
    
    func appendEvent(event: Event) {
        eventsList.append(event)
    }
    
    func appendEvent(eventJSON: NSDictionary) {
        if (eventJSON["type"] as! String == "Event") {
            let event = Event(jsonDictionary: eventJSON)
            eventsList.append(event)
        }
    }
    
    func count() -> Int {
        return eventsList.count
    }
    
    func getEventAtIndex(index: Int) -> Event {
        return eventsList[index]
    }
    
}
