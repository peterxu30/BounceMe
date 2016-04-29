//
//  Event.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Event {
    
    var type = "Event"
    var eventName: String!
    var eventDate: NSDate!
    var eventLocation: String!
    var eventDetails: String!
    var hosting: Bool!
    var signInOnce: Bool!
    
    init(eventName: String, eventDate: NSDate, eventLocation: String, eventDetails: String, hosting: Bool, signInOnce: Bool) {
        self.eventName = eventName
        self.eventDate = eventDate
        self.eventLocation = eventLocation
        self.eventDetails = eventDetails
        self.hosting = hosting
        self.signInOnce = signInOnce
    }
    
    init(jsonDictionary: NSDictionary) {
        type = jsonDictionary["type"] as! String
        eventName = jsonDictionary["eventName"] as! String
        eventDate = (jsonDictionary["eventDate"] as! NSDate)
        eventLocation = jsonDictionary["eventLocation"] as! String
        eventDetails = jsonDictionary["eventDetails"] as! String
        hosting = jsonDictionary["hosting"] as! Bool
        signInOnce = jsonDictionary["signInOnce"] as! Bool
    }
    
    func toJSON() -> NSDictionary {
        let jsonNSDic = NSMutableDictionary()
        jsonNSDic.setValue(type, forKey: "type") //.addEntriesFromDictionary(jsonDic)
        jsonNSDic.setValue(eventName, forKey: "eventName")
        jsonNSDic.setValue(eventDate, forKey: "eventDate")
        jsonNSDic.setValue(eventLocation, forKey: "eventLocation")
        jsonNSDic.setValue(eventDetails, forKey: "eventDetails")
        jsonNSDic.setValue(hosting, forKey: "hosting")
        jsonNSDic.setValue(signInOnce, forKey: "signInOnce")
        return jsonNSDic as NSDictionary
    }
    
}

extension Event: MultipeerSendableMessage {
    
    func convertTOSendableObject(sender: MCPeerID, recipient: MCPeerID?) -> NSDictionary {
        let sendableObject = NSMutableDictionary()
        sendableObject.setValue(sender, forKey: "sender")
        sendableObject.setValue(recipient, forKey: "recipeint")
        sendableObject.setValue(toJSON(), forKey: "content")
//        return NSKeyedArchiver.archivedDataWithRootObject(sendableObject as NSDictionary)
        return sendableObject
    }
    
}
