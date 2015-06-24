//
//  Delivery.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/21/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit

let postmatesCustomerID = "cus_KNNem7avnOEalF"
let postmatesAPIKey = "fda8ba46-89c3-4959-8ad3-e0dc20ff1088"
let postmatesAPIURL = "https://api.postmates.com/v1/customers/" + postmatesCustomerID

class Delivery: NSObject {
    /*  
        Use the PostMates API to setup delivery

    */
    
    var buyerAddress: [String: String]?
    var buyerName: String?
    var buyerPhone: String?
    var buyerNotes: String?
    
    var sellerAddress: [String: String]?
    var sellerName: String?
    var sellerPhone: String?
    var sellerNotes: String?
    
    var manifest: String?
    
    
    func getDeliveryQuote(buyer: [String: String], seller: [String: String]) {
        var quote: AnyObject?
        var url = postmatesAPIURL + "/delivery_quotes/?"
        let postURL = NSURL(string:url)
        let request = NSMutableURLRequest(URL: postURL!)
        let loginString = NSString(format: "%@:%@", postmatesAPIKey, "")
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        request.HTTPMethod = "POST";
        let postString = "pickup_address=3260 17th St. San Francisco,CA 94105&dropoff_address=405 Howard St. San Francisco, CA 94105"
        println("\(postString)")
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        println("\(request.allHTTPHeaderFields)")
        
        
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
            println("\(responseString)")
            
            if let parseJSON = myJSON {
                println("\(parseJSON)")
                
            }
            
        }
        
        task.resume()
        
    }
    
    // delivery.makeDelivery("address": "3260 17th St. San Francisco,CA 94105", buyerName: "Kavodel", buyerPhone: "832-659-7622", sellerAddress:["address":"405 Howard St. San Francisco, CA 94105", sellerName:"Marcus", sellerPhone:"917-972-3943", manifest:"A couch")
    
    func makeDelivery(buyerAddress: String, buyerName: String, buyerPhone: String, sellerAddress: String, sellerName: String, sellerPhone: String, manifest: String){
        
        /* Static Variables to fake pickup */
        
        var robo_pickup="00:10:00"
        var robo_pickup_complete="00:20:00"
        var robo_dropoff="00:21:00"
        var robo_delivered="00:34:00"
        
        /* */
        
        var url = postmatesAPIURL + "/deliveries/?"
        let postURL = NSURL(string:url)
        let request = NSMutableURLRequest(URL: postURL!)
        let loginString = NSString(format: "%@:%@", postmatesAPIKey, "")
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        request.HTTPMethod = "POST";
        let postString = "pickup_address=\(buyerAddress)&dropoff_address=\(sellerAddress)&pickup_name=\(buyerName)&dropoff_name=\(sellerName)&pickup_phone_number=\(sellerPhone)&dropoff_phone_number=\(buyerPhone)&robo_pickup=\(robo_pickup)&robo_pickup_complete=\(robo_pickup_complete)&robo_dropoff=\(robo_dropoff)&robo_delivered=\(robo_delivered)&manifest=\(manifest)"
        
        
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding);
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        println("\(request.allHTTPHeaderFields)")
        
        
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
            println("\(responseString)")
            
            if let parseJSON = myJSON {
                println("\(parseJSON)")
                
            }
            
        }
        
        task.resume()
        
    }
    
    func getDeliveryUpdate(){
        /* /v1/customers/:customer_id/deliveries/:delivery_id */
    }
    
   
}
