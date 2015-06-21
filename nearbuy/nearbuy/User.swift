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
    var address: NSDictionary?
    var creditCard: NSDictionary?
    var productList: [Product]?
    
    override init(){
        // var currentUser: PFUser.currentUser()
    }
    
    func registerUser(username: String, password: String){
        var user = PFUser()
        user.username = username;
        // user.email = "email@example.com"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo?["error"] as? NSString
            } else {
                
            }
        }
    }
    
    func logUserIn(username: String, password: String){
        
        PFUser.logInWithUsernameInBackground(username, password:password) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                
            } else {
                println(error?.description)
            }
        }
    }
    
    func logUserOut(){
        PFUser.logOut()
        var currentUser = PFUser.currentUser()  // This will now be nil
    }
    
    func saveCreditCard(params:NSDictionary) {
        
    }
    
    func saveAddress(params:NSDictionary){
        
    }
    
    func getProducts(params:NSDictionary) /* -> [Product]?*/ {
        
        
    }
    
   
}
