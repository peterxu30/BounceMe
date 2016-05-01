//
//  Invite.swift
//  BounceMe
//
//  Created by Peter Xu on 4/28/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class Invite {
    
    var type = "Invite"
    var eventID: String!
    var inviteeMCPeerID: MCPeerID
    var userName: String!
    var userPhoneNumber: String!
    var userEmail: String!
    
    init(profile: UserProfile, id: String) {
        inviteeMCPeerID = profile.getUserMCPeerID()
        eventID = id
        userName = profile.getUserName()
        userPhoneNumber = profile.getUserPhoneNumber()
        userEmail = profile.getUserEmail()
    }
    
    init(jsonDictionary: NSDictionary) {
        type = jsonDictionary["type"] as! String
        eventID = jsonDictionary["eventID"] as! String
        inviteeMCPeerID = jsonDictionary["inviteeMCPeerID"] as! MCPeerID
        userName = jsonDictionary["userName"] as! String
        userPhoneNumber = jsonDictionary["userPhoneNumber"] as! String
        userEmail = jsonDictionary["userEmail"] as! String
    }
    
}

extension Invite: MultipeerSendableMessage {
    
    func convertTOSendableObject(sender: MCPeerID, recipient: MCPeerID?) -> NSDictionary {
        let sendableObject = NSMutableDictionary()
        sendableObject.setValue(sender, forKey: "sender")
        sendableObject.setValue(recipient, forKey: "recipeint")
        sendableObject.setValue(toJSON(), forKey: "content")
        return sendableObject
    }
    
    private func toJSON() -> NSDictionary {
        let jsonNSDic = NSMutableDictionary()
        jsonNSDic.setValue(type, forKey: "type") //.addEntriesFromDictionary(jsonDic)
        jsonNSDic.setValue(eventID, forKey: "eventID")
        jsonNSDic.setValue(inviteeMCPeerID, forKey: "inviteeMCPeerID")
        jsonNSDic.setValue(userName, forKey: "userName")
        jsonNSDic.setValue(userPhoneNumber, forKey: "userPhoneNumber")
        jsonNSDic.setValue(userEmail, forKey: "userEmail")
        return jsonNSDic as NSDictionary
    }
}
