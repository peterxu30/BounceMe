//
//  MainTabBarController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/24/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var userProfile = UserProfile()
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        print("TabView loaded")
        userProfile = loadExistingUserProfile()
    }
    
    func loadExistingUserProfile() -> UserProfile {
        if let userProfileNSData = defaults.objectForKey("userProfile") as? NSData {
            print("exists")
            let userProfileUnarchived = NSKeyedUnarchiver(forReadingWithData: userProfileNSData)
            userProfile = userProfileUnarchived.decodeObjectForKey("root") as! UserProfile
        } else {
            defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(userProfile), forKey: "userProfile")
        }
        return userProfile
    }
    
}
