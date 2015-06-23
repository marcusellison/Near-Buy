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
var postmatesAPIURL = "https://api.postmates.com/v1/customers" + postmatesCustomerID

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
    
    func getDeliveryQuote(buyer: [String: String], sender: [String: String]){
        
        
    }
    
    func makeDelivery(){
        
    }
    
   
}
