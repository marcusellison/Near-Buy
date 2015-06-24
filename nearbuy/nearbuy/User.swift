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
    
    static let sharedInstance = User()
    
    var name: String?
    var email: String?
    var address:  String?
    var creditCard: String?
    var cvv: String?
    var expMonth: UInt?
    var expYear: UInt?
    var phone: String?
    var profilePicture: String?
    var trustScore: String?
    var history: [Product]?
    var currentUser: PFUser?
    
    // userShippingInformation = ["name": shippingName!, "streetAddress": shippingStreetAddress!, "city": shippingCity!, "state": shippingState!, "zip": shippingZip!, "phone": shippingPhone!]
    
    
    override init(){
        super.init()
        
        /* Assign any of the optional values that exist in Parse on this User object */
        currentUser = PFUser.currentUser()
        println("\(currentUser)")
        
    }
    
    func register(params: PFUser){
        var user = params
        user.username = (params["username"] as! String)
        user.password = (params["username"] as! String)
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
            } else {
                println("success")
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
    
    func save(params: [String: AnyObject]){
        var user = PFUser()
        for key in params.keys {
            user[key] = params[key]
        }
        
        println("about to save user model")
        
        user.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
            if success {
                self.currentUser = user
                self.updateUser(user)
            } else {
                /* Shit went wrong */
            }
            
        })
    }
    
    func updateUser(userToUpdate: PFUser) {
        if (userToUpdate.valueForKey("username") != nil){
            var username = userToUpdate.valueForKey("username") as! String
            User.sharedInstance.name = username
        }
        
        if (userToUpdate.valueForKey("creditCard") != nil){
            var creditCard = userToUpdate.valueForKey("creditCard") as! String
            var cvv = userToUpdate.valueForKey("cvv") as! String
            var expMonth = userToUpdate.valueForKey("expMonth") as! UInt
            var expYear = userToUpdate.valueForKey("expYear") as! UInt
            
            User.sharedInstance.creditCard = creditCard
            User.sharedInstance.cvv = cvv
            User.sharedInstance.expMonth = expMonth
            User.sharedInstance.expYear = expYear
        }
        
        if (userToUpdate.valueForKey("address") != nil){
            var address = userToUpdate.valueForKey("address") as! String
            User.sharedInstance.address = address
        }
        
        if (userToUpdate.valueForKey("profilePicture") != nil){
            var username = userToUpdate.valueForKey("profilePicture") as! String
            User.sharedInstance.profilePicture = profilePicture
        }
        
        if (userToUpdate.valueForKey("email") != nil){
            var email = userToUpdate.valueForKey("email") as! String
            User.sharedInstance.email = email
        }
        
    }
    
    /* Fetch Current User State */
    func fetch(){
        PFUser.currentUser()?.fetchInBackgroundWithBlock({ (user: PFObject?, error:NSError?) -> Void in
            if error == nil {
                self.currentUser = (user as! PFUser)
                self.updateUser(self.currentUser!)
                println("\(self.currentUser)")
            }
        })
        
    }
}
