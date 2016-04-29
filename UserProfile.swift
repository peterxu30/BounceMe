//
//  UserProfile.swift
//  BounceMe
//
//  Created by Peter Xu on 4/23/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit
import MultipeerConnectivity

class UserProfile: NSObject, NSCoding {
    
    private var userName: String!
    private var userPhoneNumber: String!
    private var userEmail: String!
    private var userMCPeerID: MCPeerID!
    
    /*
     * Only called if no profile was ever created previously.
     */
    override init() {
        userName = ""
        userPhoneNumber = ""
        userEmail = ""
        userMCPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
    }
    
    required init(coder aDecoder: NSCoder) {
        if let name = aDecoder.decodeObjectForKey("userName") {
            userName = name as! String
        } else {
            userName = ""
        }
        
        if let phoneNumber = aDecoder.decodeObjectForKey("userPhoneNumber") {
            userPhoneNumber = phoneNumber as! String
        } else {
            userPhoneNumber = ""
        }
        
        if let email = aDecoder.decodeObjectForKey("userEmail") {
            userEmail = email as! String
        } else {
            userEmail = ""
        }
        
        if let myPeerID = aDecoder.decodeObjectForKey("userMCPeerID") {
            userMCPeerID = myPeerID as! MCPeerID
        } else {
            userMCPeerID = MCPeerID(displayName: UIDevice.currentDevice().name)
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let name = userName {
            aCoder.encodeObject(name, forKey: "userName")
        }
        
        if let phoneNumber = userPhoneNumber {
            aCoder.encodeObject(phoneNumber, forKey: "userPhoneNumber")
        }
        
        if let email = userEmail {
            aCoder.encodeObject(email, forKey: "userEmail")
        }
        
        if let myPeerID = userMCPeerID {
            aCoder.encodeObject(myPeerID, forKey: "userMCPeerID")
        }
    }
    
    func getUserName() -> String {
        return userName
    }
    
    func getUserPhoneNumber() -> String {
        return userPhoneNumber
    }
    
    func getUserEmail() -> String {
        return userEmail
    }
    
    func getUserMCPeerID() -> MCPeerID {
        return userMCPeerID
    }
    
    func setUserName(name: String) {
        userName = name
    }
    
    func setUserPhoneNumber(phoneNumber: String) {
        userPhoneNumber = phoneNumber
    }
    
    func setUserEmail(email: String) {
        userEmail = email
    }
}

