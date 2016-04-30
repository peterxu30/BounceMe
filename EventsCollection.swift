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
    private var eventIDSet = Set<String>()
    
    
    func getAllEvents() -> Array<Event> {
        return eventsList //replace with eventsListDic
    }
    
    func appendEvent(event: Event) {
        if !eventIDSet.contains(event.eventID) {
            eventsList.append(event)
            eventIDSet.insert(event.eventID)
        }
        
    }
    
    func appendEvent(eventJSON: NSDictionary) {
        if (eventJSON["type"] as! String == "Event") {
            if !eventIDSet.contains(eventJSON["eventID"] as! String) {
                print(eventJSON["eventID"])
                let event = Event(jsonDictionary: eventJSON)
                eventsList.append(event)
                eventIDSet.insert(event.eventID)
                print(event.eventID)
            }
        }
    }
    
    func count() -> Int {
        return eventsList.count
    }
    
    func getEventAtIndex(index: Int) -> Event {
        return eventsList[index]
    }
    
}
