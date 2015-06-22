//
//  Product.swift
//  nearbuy
//
//  Created by Kavodel Ohiomoba on 6/10/15.
//  Copyright (c) 2015 Marcus J. Ellison. All rights reserved.
//

import UIKit
import Parse

class Product: NSObject {
    
    var products: [NSObject]?
    var productImages: [NSObject]?
    
    static let sharedInstance = Product(params: [:]);
    
    var api: API = API()
    
    /*
        Init
    
    */
    
    init(params: NSDictionary){
        /* fetch all products */
        api.queryProducts(params)
    }
    
    /*
        Query Products:
    
        Returns an optional array of Parse Objects i.e a list of all of the products that have been saved to parse.  I've added a params dictionary to filter by category ... etc.
    
        Example Usage:
    
        var params: NSDictionary = ["username":"kavodel@mixpanel.com"]
        var product: Product = Product(params: params)
        
        I'm saving this to Parse's local datastore, but if you want to upload a tableview ... etc with this data, use a notification
    
    */
    
    func get(params: NSDictionary){
        api.queryProducts(params)
    }
    
    /*
    
        Create Product:
        This maybe shouldn't return anything, but if you do want to do something with the product after it's been saved I'll return the Parse Object for you to use
        
        Example Usage:
    
        var image : UIImage = UIImage(named:"bicycle")!
        var params: NSDictionary = ["username":"kvodel@mixpanel.com", "name":"testing", "description":"testing","price":"100", "shared":"true", "category":"shoes", "image":image]
    
        var prod = product.create(params)

    */
    
    func create(params: NSDictionary) -> PFObject? {
        /* Add Product */
        var product = api.addProduct(params)
        
        return product
    }
    
    /*
        Search
    
    */
    
    func search(searchString: String, params: NSDictionary) -> [PFObject]? {
        var matchedProducts: [PFObject]?
        /* if let products = products {
            for product in products {
                if let productName: String = product["productName"] as? String {
                    if productName.rangeOfString(searchString, options: .CaseInsensitiveSearch) != nil {
                        matchedProducts!.append(product);
                    }
                }
            }
        }*/
        
        return matchedProducts
    
    }
    

    
}
