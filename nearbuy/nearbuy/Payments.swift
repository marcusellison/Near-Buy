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
    
    
    func getStripetoken(params: NSDictionary){
        /* Create a Stripe Card Object */
        
        println("in")
        let creditCard = STPCard()
        
        creditCard.number = params["number"] as? String
        creditCard.cvc = params["cvc"] as? String
        creditCard.expMonth = params["expMonth"] as! UInt
        creditCard.expYear = params["expYear"] as! UInt
        
            
        var error: NSError?
        if (creditCard.validateCardReturningError(&error)){
            var stripeError: NSError!
            STPAPIClient.sharedClient().createTokenWithCard(creditCard, completion: {(token: STPToken?, error: NSError?) -> Void in
                if let token = token {
                    // Token was returned!
                    
                    /* Charge the User */
                    println("in")
                    println("\(token)")
                    self.chargeUser("\(token)")
                } else {
                    println("\(error)")
                }
            })
        } else {
            println("\(error)")
        }
        
    }
        
    func chargeUser(token: String) -> Int {
        /* Make Call to Django Backend to Charge User */
        
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
            
            // You can print out response object
            println("response = \(response)")
            
            // Print out response body
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString)")
            
            //Let's convert response sent from a server side script to a NSDictionary object:
            
            var err: NSError?
            var myJSON = NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves, error:&err) as? NSDictionary
            
            if let parseJSON = myJSON {
                // Now we can access value of First Name by its key
                var foo = parseJSON["bar"] as? String
                println("foo: \(foo)")
            }
            
        }
        
        task.resume()
        
        
        return 1
    }
    
}
