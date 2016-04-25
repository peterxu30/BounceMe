//
//  UserProfile.swift
//  BounceMe
//
//  Created by Peter Xu on 4/23/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class UserProfile: NSObject, NSCoding {
    
    private var userName: String!
    private var userPhoneNumber: String!
    private var userEmail: String!
    
    override init() {
        userName = ""
        userPhoneNumber = ""
        userEmail = ""
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
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let name = self.userName {
            aCoder.encodeObject(name, forKey: "userName")
        }
        
        if let phoneNumber = self.userPhoneNumber {
            aCoder.encodeObject(phoneNumber, forKey: "userPhoneNumber")
        }
        
        if let email = self.userEmail {
            aCoder.encodeObject(email, forKey: "userEmail")
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

