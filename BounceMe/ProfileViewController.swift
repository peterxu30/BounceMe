//
//  ProfileNavigationController.swift
//  BounceMe
//
//  Created by Peter Xu on 4/23/16.
//  Copyright © 2016 Peter Xu. All rights reserved.
//

import UIKit

class ProfileNavigationController: UIViewController {
    
    var userProfile: UserProfile!
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userPhoneNumberTextField: UITextField!
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var saveProfileButton: UIBarButtonItem!
    @IBOutlet weak var cancelProfileEditsButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBarController = self.tabBarController as! MainTabBarController
        
        userProfile = tabBarController.userProfile
        
        userNameTextField?.text = userProfile.getUserName()
        userPhoneNumberTextField?.text = userProfile.getUserPhoneNumber()
        userEmailTextField?.text = userProfile.getUserEmail()
    }
    
    @IBAction func barButtonPressed(sender: AnyObject) {
        if sender as! UIBarButtonItem == saveProfileButton {
            saveProfile()
        } else if sender as! UIBarButtonItem == cancelProfileEditsButton {
            resetProfileTextFields()
        }
    }
    
    func saveProfile() {
        print("saved")
        userProfile.setUserName(userNameTextField.text!)
        userProfile.setUserPhoneNumber(userPhoneNumberTextField.text!)
        userProfile.setUserEmail(userEmailTextField.text!)
        defaults.setObject(NSKeyedArchiver.archivedDataWithRootObject(userProfile), forKey: "userProfile")
    }
    
    func resetProfileTextFields() {
        userNameTextField.text = userProfile.getUserName()
        userPhoneNumberTextField.text = userProfile.getUserPhoneNumber()
        userEmailTextField.text = userProfile.getUserEmail()
    }
    
}
