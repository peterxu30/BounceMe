//
//  InvitesCollection.swift
//  BounceMe
//
//  Created by Peter Xu on 4/29/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class InvitesCollection {
    
    let calendar = NSCalendar.currentCalendar()
    
    private var invitesList = Array<Invite>()
    private var inviteIDSet = Set<MCPeerID>()
    
    
    func getAllInvites() -> Array<Invite> {
        return invitesList //replace with eventsListDic
    }
    
    func appendInvite(invite: Invite) {
        if !inviteIDSet.contains(invite.inviteeMCPeerID) {
            invitesList.append(invite)
            inviteIDSet.insert(invite.inviteeMCPeerID)
        }
        
    }
    
    func appendInvite(inviteJSON: NSDictionary) {
        if (inviteJSON["type"] as! String == "Event") {
            if !inviteIDSet.contains(inviteJSON["inviteeMCPeerID"] as! MCPeerID) {
                print(inviteJSON["eventID"])
                let invite = Invite(jsonDictionary: inviteJSON)
                invitesList.append(invite)
                inviteIDSet.insert(invite.inviteeMCPeerID)
                print(invite.inviteeMCPeerID)
            }
        }
    }
    
    func count() -> Int {
        return invitesList.count
    }
    
    func getInviteAtIndex(index: Int) -> Invite {
        return invitesList[index]
    }

}
