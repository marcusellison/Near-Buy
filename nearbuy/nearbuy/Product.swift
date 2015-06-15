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
    
    
    var products: [PFObject]?
    var api: RestfulAPI?
    
    /*
        Init
    */
    
    init(params: NSDictionary){
        var api = RestfulAPI();
        
        /* fetch all products */
        products = api.queryProducts(params)
    }
    
    /*
        Query Products:
    
        Returns an optional array of Parse Objects.
    */
    
    func get(params: NSDictionary) -> [PFObject]? {
        products = api?.queryProducts(params)
        
        return products
    }
    
    /* 
        Create Product:
    
        This maybe shouldn't return anything, but if you do want to do something with the product after it's been saved I'll return the Parse Object for you to use
    */
    
    func create(params: NSDictionary) -> PFObject {
        /* Add Product */
        var product = api?.addProduct(params)
        
        return product!
    }
    
    /*
        Search
    
    */
    
    func search(searchString: String, params: NSDictionary) -> [PFObject]? {
        var matchedProducts: [PFObject]?
        if let products = products {
            for product in products {
                if let productName: String = product["productName"] as? String {
                    if productName.rangeOfString(searchString, options: .CaseInsensitiveSearch) != nil {
                        matchedProducts!.append(product);
                    }
                }
            }
        }
        
        return matchedProducts
    
    }
    

    
}
