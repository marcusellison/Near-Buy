//
//  Payments.swift
//  nearbuy
//
//  Created by Lily Chen on 6/19/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class Payments: NSObject {
    
    /*
        email
        Credit Card Number,
        expiration,
        cvc
        Name,
        Token,
    */
    lazy var user: User = User()
    
    
    func chargeUser(params: [String:AnyObject], amount:String){
        /* Create a Stripe Card Object */
        let creditCard = STPCard()
        
        creditCard.number = User.sharedInstance.creditCard!
        creditCard.cvc = User.sharedInstance.cvv!
        creditCard.expMonth = User.sharedInstance.expMonth!
        creditCard.expYear = User.sharedInstance.expYear!
        
            
        var error: NSError?
        if (creditCard.validateCardReturningError(&error)){
            var stripeError: NSError!
            STPAPIClient.sharedClient().createTokenWithCard(creditCard, completion: {(token: STPToken?, error: NSError?) -> Void in
                if let token = token {
                    /* Charge the User */
                    self.sendChargeToStripe("\(token)", amount: amount)
                    
                    /*self.user.currentUser?.saveInBackgroundWithBlock({ (success:Bool, error: NSError?) -> Void in
                        
                    })*/
                    /* Also increment the amount on the Parse Object */
                    
                } else {
                    println("\(error)")
                    
                }
            })
        } else {
            println("\(error)")
        }
        
    }
        
    func sendChargeToStripe(token: String, amount:String) {
        /* Make Call to Django Backend to Charge User */
        
        
        /* Add the amount of the purchase to this user's Parse Profile */
        
        let paymentsURL = NSURL(string:"http://104.236.212.145:8000/payments/")
        let request = NSMutableURLRequest(URL: paymentsURL!)
        
        request.HTTPMethod = "POST";
        
        let postString = "token=\(token)"
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            
            if error != nil
            {
                println("error=\(error)")
                return
            }
            
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
            
            if let parseJSON = myJSON {
                var foo = parseJSON["bar"] as? String
                println("foo: \(foo)")
                
            }
            
        }
        
        task.resume()
    }
    
}
