//
//  Invite.swift
//  BounceMe
//
//  Created by Peter Xu on 4/28/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class Invite {
    
    var type = "Invite"
    var userName: String!
    var userPhoneNumber: String!
    var userEmail: String!
    
    init(profile: UserProfile) {
        userName = profile.getUserName()
        userPhoneNumber = profile.getUserPhoneNumber()
        userEmail = profile.getUserEmail()
    }
    
    init(jsonDictionary: NSDictionary) {
        type = jsonDictionary["type"] as! String
        userName = jsonDictionary["userName"] as! String
        userPhoneNumber = jsonDictionary["userPhoneNumber"] as! String
        userEmail = jsonDictionary["userEmail"] as! String
    }
    
    func toJSON() -> NSDictionary {
        var jsonNSDic = NSMutableDictionary()
        jsonNSDic.setValue(type, forKey: "type") //.addEntriesFromDictionary(jsonDic)
        jsonNSDic.setValue(userName, forKey: "userName")
        jsonNSDic.setValue(userPhoneNumber, forKey: "userPhoneNumber")
        jsonNSDic.setValue(userEmail, forKey: "userEmail")
        return jsonNSDic as NSDictionary
    }
    
}
