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
        super.init()
        
        /* Assign any of the optional values that exist in Parse on this User object */
        currentUser = PFUser.currentUser()
    }
    
    func register(params: Dictionary<String, AnyObject>){
        var user = PFUser()
        user.username = (params["username"] as! String)
        user.password = (params["username"] as! String)
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
            } else {
                println("success")
                self.save(params)
            }
        }
        
        
    }
    
    func login(params: Dictionary<String, AnyObject>){
        let username = params["username"] as! String
        let password = params["username"] as! String
        
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                println("success")
            } else {
                println(error?.description)
            }
        }
    }
    
    /* Logout User and set currentUser to nil */
    func logUserOut(){
        PFUser.logOut()
    }
    
    /* Save attributes to a user */
    
    func save(params:Dictionary<String, AnyObject>) {
        var user = PFUser()
        var attributes = PFObject(className: "Attributes", dictionary: params)
        user["attributes"] = attributes
        user.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
            if success {
                self.currentUser = user
            } else {
                /* Shit went wrong */
            }
            
        })
        println("\(user)")
    }
    
    func update(params:Dictionary<String, AnyObject>) {
        
        
    }
    
    /* Fetch Current User State */
    func fetch(username: String){
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user: PFObject?, error:NSError?) -> Void in
            if error == nil {
                self.currentUser = (user as! PFUser)
                println("\(user)")
            }
        })
        
    }
}
