//
//  RestfulAPI.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/9/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse


let applicationID = "MXh7k8fs6DYgHe3289YMuEiVXfVT3tfgc39DMqXm"
let clientKey = "0co1OmbuCeuovw5r2YdbiJ7wh9AkczJaMdoLGOF0"

class RestfulAPI: NSObject {
    
    
    func initParse() {
        Parse.enableLocalDatastore()
        Parse.setApplicationId(applicationID, clientKey: clientKey)
    }
    
    func registerUser(username: String, password: String){
        var user = PFUser()
        user.username = username;
        user.password = password;
        user.email = "email@example.com"
        
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
    
    
    
    func addProduct(productInfo: NSDictionary) -> PFObject {
        var product = PFObject(className: "Product")
        
        /* add Properties */
        product["productName"] = productInfo["name"]
        product["description"] = productInfo["description"]
        product["price"] = productInfo["price"]
        product["shared"] = productInfo["shared"]
        product["category"] = productInfo["category"]
        
        product.saveInBackgroundWithBlock { (success:Bool, error: NSError?) -> Void in
            if (success) {
                // product saved: celebrate: go home
            } else {
                println(error!.description)
            }
        }
        
        return product
    }
    
    /* finish this */
    func deleteProduct(object: PFObject) -> Bool {
        
        /* get the specific object ID and delete that one */
        
        return true;
    }
    
    func queryProducts(params: NSDictionary) -> [NSDictionary] {
        /* Query for all products */
        var query = PFQuery(className:"Product")
        
        return [["url":"dictionary"]]
    }
    
}
