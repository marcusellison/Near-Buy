//
//  User.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/10/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    
    var name: String?
    var email: String?
    var address: Dictionary<String, String>?
    var creditCard: Dictionary<String, String>?
    var purchases: [Product]?
    var currentUser: PFUser?
    
    
    override init(){
        /* Assign any of the optional values that exist in Parse on this User object */
    }
    
    func registerUser(username: String, password: String){
        var user = PFUser()
        user.username = username;
        user.password = username;
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
            } else {
                /* Set this user to the current user */
                self.currentUser = user
            }
        }
        
        
    }
    
    func logUserIn(username: String, password: String){
        
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                self.currentUser = user;
                
            } else {
                println(error?.description)
            }
        }
    }
    
    /* Logout User and set currentUser to nil */
    func logUserOut(){
        PFUser.logOut()
        var currentUser = PFUser.currentUser()
    }
    
    /* Save attributes to a user */
    
    func save(params:Dictionary<String, String>) {
        var attributes = PFObject(className: "Attributes", dictionary: params)
        
        attributes.save()
    }
    
}
