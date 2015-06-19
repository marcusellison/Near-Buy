//
//  Payments.swift
//  nearbuy
//
//  Created by Lily Chen on 6/19/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit


class Payments: NSObject {
    
    /*
        email
        Credit Card Number,
        expiration,
        cvc
        Name,
        Token,
    */
    
    
    func getStripetoken(params: NSDictionary) -> Int {
        /* Create a Stripe Card Object */
            
        let creditCard = STPCard()
        
        creditCard.number = params["number"] as? String
        creditCard.cvc = params["cvc"] as? String
            
        var error: NSError?
        if (creditCard.validateCardReturningError(&error)){
            var stripeError: NSError!
            STPAPIClient.sharedClient().createTokenWithCard(creditCard, completion: {(token: STPToken?, error: NSError?) -> Void in
                if let token = token {
                    // Token was returned!
                    
                    /* Charge the User */
                    self.chargeUser()
                } else {
                    println("\(error)")
                }
            })
        }
        
        return 1 // On success else 0?
    }
        
    func chargeUser() -> Int {
        /* Make Call to Django Backend to Charge User */
        
        
        return 1
    }
}
