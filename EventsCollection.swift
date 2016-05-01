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
    private var eventIDToIndex = Dictionary<String, Int>()
    
    func getEventByEventID(id: String) -> Event {
        return eventsList[eventIDToIndex[id]!]
    }
    
    func getAllEvents() -> Array<Event> {
        return eventsList //replace with eventsListDic
    }
    
    func appendEvent(event: Event) {
        if (eventIDToIndex[event.eventID]) == nil {
            eventsList.append(event)
            eventIDToIndex[event.eventID] = eventsList.count - 1
        }
        
    }
    
    func appendEvent(eventJSON: NSDictionary) {
        if (eventJSON["type"] as! String == "Event") {
            if (eventIDToIndex[(eventJSON["eventID"] as! String)] == nil) {
                print(eventJSON["eventID"])
                let event = Event(jsonDictionary: eventJSON)
                eventsList.append(event)
                eventIDToIndex[event.eventID] = eventsList.count - 1
                print(event.eventID)
            }
        }
    }
    
    func removeEventAtIndex(index: Int) {
        eventIDToIndex.removeValueForKey(eventsList[index].eventID)
        eventsList.removeAtIndex(index)
    }
    
    func count() -> Int {
        return eventsList.count
    }
    
    func getEventAtIndex(index: Int) -> Event {
        return eventsList[index]
    }
    
}
